use crate::ast::{Attrs, Document, Kind, Node};
use crate::lexer::{Span, Token, TokenKind};

#[derive(Debug, Clone)]
pub struct ParseError {
    pub message: String,
    pub span: Span,
}

impl std::fmt::Display for ParseError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{} at {}:{}", self.message, self.span.line, self.span.col)
    }
}

pub struct Parser<'a> {
    tokens: &'a [Token],
    i: usize,
}

impl<'a> Parser<'a> {
    pub fn new(tokens: &'a [Token]) -> Self {
        Self { tokens, i: 0 }
    }

    fn peek(&self) -> &'a Token {
        self.tokens.get(self.i).unwrap_or_else(|| self.tokens.last().expect("tokens empty"))
    }

    fn next(&mut self) -> &'a Token {
        let t = self.peek();
        if !matches!(t.kind, TokenKind::Eof) {
            self.i += 1;
        }
        t
    }

    fn expect_dot(&mut self) -> Result<(), ParseError> {
        let t = self.next();
        match &t.kind {
            TokenKind::Dot => Ok(()),
            _ => Err(ParseError { message: "expected '.'".to_string(), span: t.span }),
        }
    }

    fn expect_number(&mut self) -> Result<(u16, Span), ParseError> {
        let t = self.next();
        match &t.kind {
            TokenKind::Number(n) => Ok((*n, t.span)),
            _ => Err(ParseError { message: "expected level number".to_string(), span: t.span }),
        }
    }

    fn expect_ident(&mut self) -> Result<(String, Span), ParseError> {
        let t = self.next();
        match &t.kind {
            TokenKind::Ident(s) => Ok((s.clone(), t.span)),
            _ => Err(ParseError { message: "expected identifier".to_string(), span: t.span }),
        }
    }

    fn expect_string(&mut self) -> Result<(String, Span), ParseError> {
        let t = self.next();
        match &t.kind {
            TokenKind::StringLit(s) => Ok((s.clone(), t.span)),
            _ => Err(ParseError { message: "expected string literal".to_string(), span: t.span }),
        }
    }

    fn ident_eq(t: &Token, kw: &str) -> bool {
        match &t.kind {
            TokenKind::Ident(s) => s.eq_ignore_ascii_case(kw),
            _ => false,
        }
    }

    fn parse_pic_len(&mut self) -> Result<Option<usize>, ParseError> {
        // expects: PIC X ( NUMBER )
        let (x, span) = self.expect_ident()?;
        if !x.eq_ignore_ascii_case("X") {
            return Err(ParseError { message: "expected PIC X(...)".to_string(), span });
        }
        let t = self.next();
        if !matches!(t.kind, TokenKind::LParen) {
            return Err(ParseError { message: "expected '(' after X".to_string(), span: t.span });
        }
        let (n, _nspan) = self.expect_number()?;
        let t = self.next();
        if !matches!(t.kind, TokenKind::RParen) {
            return Err(ParseError { message: "expected ')'".to_string(), span: t.span });
        }
        Ok(Some(n as usize))
    }

    fn parse_statement(&mut self) -> Result<(u16, Node), ParseError> {
        let (level, _lspan) = self.expect_number()?;
        let (name, nspan) = self.expect_ident()?;

        let mut attrs = Attrs::default();
        let mut pic_len: Option<usize> = None;
        let mut value: Option<String> = None;

        // read until '.'
        loop {
            let t = self.peek();
            match &t.kind {
                TokenKind::Dot => {
                    self.expect_dot()?;
                    break;
                }
                TokenKind::Eof => {
                    return Err(ParseError {
                        message: "unexpected EOF (missing '.')".to_string(),
                        span: t.span,
                    });
                }
                _ => {
                    // Known keywords
                    if Self::ident_eq(t, "PIC") {
                        self.next();
                        pic_len = self.parse_pic_len()?;
                        continue;
                    }
                    if Self::ident_eq(t, "VALUE") {
                        self.next();
                        let (s, _sspan) = self.expect_string()?;
                        value = Some(s);
                        continue;
                    }
                    if Self::ident_eq(t, "ID") {
                        self.next();
                        let (s, _sspan) = self.expect_string()?;
                        attrs.id = Some(s);
                        continue;
                    }
                    if Self::ident_eq(t, "CLASS") {
                        self.next();
                        let (s, _sspan) = self.expect_string()?;
                        // "a b c" -> ["a","b","c"]
                        attrs.classes.extend(s.split_whitespace().map(|x| x.to_string()));
                        continue;
                    }

                    // Generic props: TYPE/NAME/PLACEHOLDER/HREF/SRC/ALT/...
                    if let TokenKind::Ident(key) = &t.kind {
                        let key_up = key.to_ascii_uppercase();
                        self.next();
                        let (val, _vspan) = self.expect_string().map_err(|_| ParseError {
                            message: format!("expected string after {}", key_up),
                            span: t.span,
                        })?;
                        attrs.set_prop(key_up, val);
                        continue;
                    }

                    return Err(ParseError {
                        message: "unexpected token in statement".to_string(),
                        span: t.span,
                    });
                }
            }
        }

        let kind = match name.to_ascii_uppercase().as_str() {
            "SCREEN" => Kind::Screen,
            "HEADER" => Kind::Header,
            "BODY" => Kind::Body,
            "FOOTER" => Kind::Footer,
            "ROW" => Kind::Row,
            "COL" => Kind::Col,

            "CENTER" => Kind::Center,
            "HR" => Kind::Hr,
            "BR" => Kind::Br,
            "LIST" => Kind::List,
            "ITEM" => Kind::Item,
            "TABLE" => Kind::Table,
            "TR" => Kind::Tr,
            "TD" => Kind::Td,
            "MARQUEE" => Kind::Marquee,

            "TEXT" => Kind::Text { value: value.clone().unwrap_or_default() },
            "LABEL" => Kind::Label { value: value.clone().unwrap_or_default() },
            "INPUT" => Kind::Input { len: pic_len },
            "BUTTON" => Kind::Button { value: value.clone().unwrap_or_default() },
            "LINK" => Kind::Link { value: value.clone().unwrap_or_default() },
            "IMAGE" => Kind::Image,

            other => Kind::Unknown { name: other.to_string() },
        };

        if matches!(kind, Kind::Text { .. } | Kind::Label { .. } | Kind::Button { .. } | Kind::Link { .. })
            && value.is_none()
        {
            // return Err(ParseError { message: "TEXT/LABEL/BUTTON/LINK requires VALUE \"...\"".to_string(), span: nspan });
            let _ = nspan;
        }

        if matches!(kind, Kind::Input { .. }) && attrs.get_prop("TYPE").is_none() {
            attrs.set_prop("TYPE", "text");
        }

        let mut node = Node::new(kind);
        node.attrs = attrs;
        Ok((level, node))
    }

    pub fn parse_document(&mut self) -> Result<Document, ParseError> {
        let mut doc = Document::new();
        let mut stack: Vec<(u16, usize)> = Vec::new();

        loop {
            if matches!(self.peek().kind, TokenKind::Eof) {
                break;
            }

            let (level, node) = self.parse_statement()?;
            let id = doc.push_node(node);

            while let Some((prev_level, _)) = stack.last() {
                if level <= *prev_level {
                    stack.pop();
                } else {
                    break;
                }
            }

            if let Some((_, parent_id)) = stack.last().copied() {
                doc.arena[parent_id].children.push(id);
            } else {
                doc.roots.push(id);
            }

            stack.push((level, id));
        }

        Ok(doc)
    }
}
