use std::sync::{Arc, Mutex};
use bytes::{BufMut, BytesMut};
use rppal::uart::{Parity, Uart};
use crate::motor::{Direction, Side};

pub type HardwareStatePointer = Arc<Mutex<HardwareState>>;

pub enum PacketType {
    MotorDirection,
    MotorSpeed
}

pub struct HardwareState {
    pub uart: Uart
}

impl HardwareState {
    pub fn new() -> HardwareStatePointer {
        let uart = Uart::new(115200, Parity::None, 8, 1).expect("Failed to get uart handle");
        Arc::new(Mutex::new(HardwareState {
            uart
        }))
    }
    pub fn write_packet(&mut self, packet_type: PacketType, data: BytesMut) {
        let mut packet_data = BytesMut::new();
        packet_data.put_u8(packet_type as u8);
        packet_data.put(data);

        let mut frame = BytesMut::new();
        frame.put_u8(packet_data.len() as u8);
        frame.put(packet_data);
        self.uart.write(frame.as_ref()).expect("Failed to write packet");
    }
    pub fn change_motor_direction(&mut self, side: &Side, direction: &Direction) {
        let mut buffer = BytesMut::new();
        buffer.put_u8(*side as u8);
        buffer.put_u8(*direction as u8);
        self.write_packet(PacketType::MotorDirection, buffer);
    }
    pub fn change_motor_speed(&mut self, side: &Side, speed: &u8) {
        let mut buffer = BytesMut::new();
        buffer.put_u8(*side as u8);
        buffer.put_u8(*speed);
        self.write_packet(PacketType::MotorSpeed, buffer);
    }
}