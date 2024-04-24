#[derive(Debug, Copy, Clone)]
#[repr(u8)]
pub enum Side {
    RIGHT,
    LEFT
}

#[derive(Debug, Copy, Clone)]
#[repr(u8)]
pub enum Direction {
    FORWARD,
    BACKWARD
}