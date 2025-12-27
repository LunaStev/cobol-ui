use crate::ast::{Document, Kind};

use std::collections::BTreeSet;

fn is_nostyle(doc: &Document) -> bool {
    for &root in &doc.roots {
        let n = &doc.arena[root];
        if let Some(v) = n.attrs.get_prop("NOSTYLE") {
            let v = v.to_ascii_lowercase();
            if v == "true" || v == "1" || v == "yes" {
                return true;
            }
        }
    }
    false
}


pub fn enrich(doc: &mut Document) {
    let mut used: BTreeSet<String> = BTreeSet::new();
    for n in &doc.arena {
        if let Some(id) = &n.attrs.id {
            used.insert(id.clone());
        }
    }

    for i in 0..doc.arena.len() {
        if !matches!(doc.arena[i].kind, Kind::Body) {
            continue;
        }

        let children = doc.arena[i].children.clone();
        let mut idx = 0usize;

        while idx < children.len() {
            let cid = children[idx];
            let is_label = matches!(doc.arena[cid].kind, Kind::Label { .. });
            if !is_label {
                idx += 1;
                continue;
            }

            let Some(next_id) = children.get(idx + 1).copied() else {
                idx += 1;
                continue;
            };

            if !matches!(doc.arena[next_id].kind, Kind::Input { .. }) {
                idx += 1;
                continue;
            }

            if doc.arena[next_id].attrs.id.is_none() {
                let base = match &doc.arena[cid].kind {
                    Kind::Label { value } => slugify(value),
                    _ => "field".to_string(),
                };
                let r#gen = gen_unique_id(&base, &mut used);
                doc.arena[next_id].attrs.id = Some(r#gen);
            }

            // label for 지정 (props로 저장: FOR)
            if doc.arena[cid].attrs.get_prop("FOR").is_none() {
                if let Some(id) = doc.arena[next_id].attrs.id.clone() {
                    doc.arena[cid].attrs.set_prop("FOR", id);
                }
            }

            idx += 2;
        }
    }
}

fn slugify(s: &str) -> String {
    let mut out = String::new();
    let mut prev_dash = false;

    for ch in s.trim().chars() {
        let c = ch.to_ascii_lowercase();
        if c.is_ascii_alphanumeric() {
            out.push(c);
            prev_dash = false;
        } else if c == ' ' || c == '-' || c == '_' {
            if !prev_dash && !out.is_empty() {
                out.push('-');
                prev_dash = true;
            }
        }
    }

    while out.ends_with('-') {
        out.pop();
    }
    if out.is_empty() { "field".to_string() } else { out }
}

fn gen_unique_id(base: &str, used: &mut BTreeSet<String>) -> String {
    if !used.contains(base) {
        used.insert(base.to_string());
        return base.to_string();
    }
    for n in 2..=9999 {
        let cand = format!("{}-{}", base, n);
        if !used.contains(&cand) {
            used.insert(cand.clone());
            return cand;
        }
    }
    format!("{}-{}", base, "x")
}

pub fn render(doc: &Document) -> String {
    let mut out = String::new();
    let nostyle = is_nostyle(doc);
    push_line(&mut out, 0, "<!doctype html>");
    push_line(&mut out, 0, "<html>");
    push_line(&mut out, 0, "<head>");
    push_line(&mut out, 1, "<meta charset=\"utf-8\">");
    push_line(&mut out, 1, "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
    push_line(&mut out, 1, "<title>cobol-ui</title>");
    if !nostyle {
        push_line(&mut out, 1, "<style>");
        push_line(&mut out, 2, "body { margin: 0; padding: 16px; font-family: system-ui, sans-serif; }");
        push_line(&mut out, 2, ".screen { display: flex; flex-direction: column; gap: 12px; }");
        push_line(&mut out, 2, "header, main, footer { display: flex; flex-direction: column; gap: 8px; }");
        push_line(&mut out, 2, ".row { display: flex; flex-direction: row; gap: 8px; align-items: center; flex-wrap: wrap; }");
        push_line(&mut out, 2, ".col { display: flex; flex-direction: column; gap: 8px; }");
        push_line(&mut out, 2, "input, button { padding: 8px 10px; font-size: 14px; }");
        push_line(&mut out, 1, "</style>");
    }
    push_line(&mut out, 1, "</style>");
    push_line(&mut out, 0, "</head>");
    push_line(&mut out, 0, "<body>");

    for &root in &doc.roots {
        render_node(doc, root, &mut out, 1, None, nostyle);
    }

    push_line(&mut out, 0, "</body>");
    push_line(&mut out, 0, "</html>");
    out
}

fn push_line(out: &mut String, indent: usize, s: &str) {
    for _ in 0..indent {
        out.push_str("  ");
    }
    out.push_str(s);
    out.push('\n');
}

fn esc(s: &str) -> String {
    s.replace('&', "&amp;")
        .replace('<', "&lt;")
        .replace('>', "&gt;")
        .replace('"', "&quot;")
        .replace('\'', "&#39;")
}

fn attrs_html(doc: &Document, id: usize, extra: &[(&str, String)]) -> String {
    let node = &doc.arena[id];
    let mut parts: Vec<String> = vec![];

    if let Some(idv) = &node.attrs.id {
        parts.push(format!("id=\"{}\"", esc(idv)));
    }
    if !node.attrs.classes.is_empty() {
        let class = node.attrs.classes.join(" ");
        parts.push(format!("class=\"{}\"", esc(&class)));
    }

    for (k, v) in &node.attrs.props {
        if k == "FOR" || k == "AS" || k == "NOSTYLE" {
            continue;
        }
        let key = k.to_ascii_lowercase();
        parts.push(format!("{}=\"{}\"", esc(&key), esc(v)));
    }

    for (k, v) in extra {
        parts.push(format!("{}=\"{}\"", esc(k), esc(v)));
    }

    if parts.is_empty() {
        "".to_string()
    } else {
        format!(" {}", parts.join(" "))
    }
}

fn render_node(
    doc: &Document,
    id: usize,
    out: &mut String,
    indent: usize,
    parent: Option<&Kind>,
    nostyle: bool,
) {
    let node = &doc.arena[id];

    match &node.kind {
        Kind::Screen => {
            let a = if nostyle {
                attrs_html(doc, id, &[])
            } else {
                attrs_html(doc, id, &[("class", "screen".to_string())])
            };
            push_line(out, indent, &format!("<div{}>", a));
            for &c in &node.children { render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle); }
            push_line(out, indent, "</div>");
        }

        Kind::Header => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<header{}>", a));
            for &c in &node.children {
                render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle);
            }
            push_line(out, indent, "</header>");
        }

        Kind::Body => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<main{}>", a));
            for &c in &node.children {
                render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle);
            }
            push_line(out, indent, "</main>");
        }

        Kind::Footer => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<footer{}>", a));
            for &c in &node.children {
                render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle);
            }
            push_line(out, indent, "</footer>");
        }

        Kind::Row => {
            let a = attrs_html(doc, id, &[("class", "row".to_string())]);
            push_line(out, indent, &format!("<div{}>", a));
            for &c in &node.children {
                render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle);
            }
            push_line(out, indent, "</div>");
        }

        Kind::Col => {
            let a = attrs_html(doc, id, &[("class", "col".to_string())]);
            push_line(out, indent, &format!("<div{}>", a));
            for &c in &node.children {
                render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle);
            }
            push_line(out, indent, "</div>");
        }

        Kind::Center => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<center{}>", a));
            for &c in &node.children { render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle); }
            push_line(out, indent, "</center>");
        }

        Kind::Hr => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<hr{}>", a));
        }

        Kind::Br => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<br{}>", a));
        }

        Kind::List => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<ul{}>", a));
            for &c in &node.children { render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle); }
            push_line(out, indent, "</ul>");
        }

        Kind::Item => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<li{}>", a));
            for &c in &node.children { render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle); }
            push_line(out, indent, "</li>");
        }

        Kind::Table => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<table{}>", a));
            for &c in &node.children { render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle); }
            push_line(out, indent, "</table>");
        }

        Kind::Tr => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<tr{}>", a));
            for &c in &node.children { render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle); }
            push_line(out, indent, "</tr>");
        }

        Kind::Td => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<td{}>", a));
            for &c in &node.children { render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle); }
            push_line(out, indent, "</td>");
        }

        Kind::Marquee => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<marquee{}>", a));
            for &c in &node.children { render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle); }
            push_line(out, indent, "</marquee>");
        }

        Kind::Text { value } => {
            let mut tag = match parent {
                Some(Kind::Header) => "h1",
                _ => "p",
            };

            if let Some(as_tag) = node.attrs.get_prop("AS") {
                let t = as_tag.to_ascii_lowercase();
                // 안전하게 허용 목록만
                let ok = ["p","h1","h2","h3","h4","h5","h6","pre","blockquote"];
                if ok.contains(&t.as_str()) {
                    tag = match t.as_str() {
                        "p" => "p",
                        "h1" => "h1",
                        "h2" => "h2",
                        "h3" => "h3",
                        "h4" => "h4",
                        "h5" => "h5",
                        "h6" => "h6",
                        "pre" => "pre",
                        "blockquote" => "blockquote",
                        _ => tag,
                    };
                }
            }

            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<{tag}{a}>{}</{tag}>", esc(value)));
        }

        Kind::Label { value } => {
            // props에 FOR가 있으면 label for로 출력
            let mut extra = vec![];
            if let Some(f) = node.attrs.get_prop("FOR") {
                extra.push(("for", f.to_string()));
            }
            let a = attrs_html(doc, id, &extra);
            push_line(out, indent, &format!("<label{a}>{}</label>", esc(value)));
        }

        Kind::Input { len } => {
            let mut extra = vec![];
            if let Some(n) = len {
                extra.push(("size", n.to_string()));
            }
            let a = attrs_html(doc, id, &extra);
            push_line(out, indent, &format!("<input{a}>"));
        }

        Kind::Button { value } => {
            // type 기본: button
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<button{a}>{}</button>", esc(value)));
        }

        Kind::Link { value } => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<a{a}>{}</a>", esc(value)));
        }

        Kind::Image => {
            let a = attrs_html(doc, id, &[]);
            push_line(out, indent, &format!("<img{a}>"));
        }

        Kind::Unknown { name } => {
            let a = attrs_html(doc, id, &[("data-unknown", name.clone())]);
            push_line(out, indent, &format!("<div{a}>"));
            for &c in &node.children {
                render_node(doc, c, out, indent + 1, Some(&node.kind), nostyle);
            }
            push_line(out, indent, "</div>");
        }
    }
}
