use rocket::{get, State};
use crate::hardware::HardwareStatePointer;
use crate::motor::{Direction, Side};

#[get("/motor/direction/<side>/<direction>")]
pub fn change_motor_direction(side: &str, direction: &str, hardware: &State<HardwareStatePointer>) -> String {
    let side = match side {
        "right" => Side::RIGHT,
        "left" => Side::LEFT,
        _ => {
            return format!("Invalid side {:?}", side);
        }
    };
    let direction = match direction {
        "forward" => Direction::FORWARD,
        "backward" => Direction::BACKWARD,
        _ => {
            return format!("Invalid direction {:?}", direction);
        }
    };
    let mut hardware = hardware.lock().unwrap();
    hardware.change_motor_direction(&side, &direction);
    format!("OK[{:?} to {:?}]", side, direction)
}

#[get("/motor/speed/<side>/<speed>")]
pub fn change_motor_speed(side: &str, speed: u8, hardware: &State<HardwareStatePointer>) -> String {
    let side = match side {
        "right" => Side::RIGHT,
        "left" => Side::LEFT,
        _ => {
            return format!("Invalid side {:?}", side);
        }
    };
    let mut hardware = hardware.lock().unwrap();
    hardware.change_motor_speed(&side, &speed);
    format!("OK[{:?} to {:?}]", side, speed)
}