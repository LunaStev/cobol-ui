use std::collections::BTreeMap;

#[derive(Debug, Clone)]
pub struct Document {
    pub arena: Vec<Node>,
    pub roots: Vec<usize>,
}

impl Document {
    pub fn new() -> Self {
        Self { arena: vec![], roots: vec![] }
    }

    pub fn push_node(&mut self, node: Node) -> usize {
        let id = self.arena.len();
        self.arena.push(node);
        id
    }
}

#[derive(Debug, Clone, Default)]
pub struct Attrs {
    pub id: Option<String>,
    pub classes: Vec<String>,
    /// 기타 속성들 (TYPE/HREF/SRC/...)
    pub props: BTreeMap<String, String>,
}

impl Attrs {
    pub fn set_prop(&mut self, k: impl Into<String>, v: impl Into<String>) {
        self.props.insert(k.into(), v.into());
    }

    pub fn get_prop(&self, k: &str) -> Option<&str> {
        self.props.get(k).map(|s| s.as_str())
    }
}

#[derive(Debug, Clone)]
pub struct Node {
    pub kind: Kind,
    pub attrs: Attrs,
    pub children: Vec<usize>,
}

impl Node {
    pub fn new(kind: Kind) -> Self {
        Self { kind, attrs: Attrs::default(), children: vec![] }
    }
}

#[derive(Debug, Clone)]
pub enum Kind {
    Screen,
    Header,
    Body,
    Footer,

    Row,
    Col,

    Center,
    Hr,
    Br,
    List,   // <ul>
    Item,   // <li>
    Table,
    Tr,
    Td,
    Marquee,

    Text { value: String },
    Label { value: String },

    Input { len: Option<usize> },
    Button { value: String },

    Link { value: String },
    Image,

    Unknown { name: String },
}
