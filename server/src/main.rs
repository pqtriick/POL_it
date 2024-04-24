use rocket::{launch, routes};

use crate::endpoints::{change_motor_direction, change_motor_speed};
use crate::hardware::HardwareState;

mod hardware;
mod endpoints;
mod motor;

#[launch]
fn rocket() -> _ {
    rocket::build()
        .manage(HardwareState::new())
        .mount("/", routes![change_motor_direction, change_motor_speed])
}