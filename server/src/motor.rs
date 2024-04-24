#[derive(Debug, Copy, Clone)]
#[repr(u8)]
pub enum Side {
    Right,
    Left
}

#[derive(Debug, Copy, Clone)]
#[repr(u8)]
pub enum Direction {
    Forward,
    Backward
}