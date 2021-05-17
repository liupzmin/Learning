#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}


impl Rectangle{
    fn area(&self) -> u32 {
        self.width * self.height
    }
    fn square(size: u32) -> Rectangle {
        Rectangle{
            width: size,
            height: size,
        }
    }
}

fn main() {
    let rec1 = Rectangle{
        width: 5,
        height: 10,
    };

    println!("the area of the rectangle is {:?}.", rec1.area());
    println!("a square is {:?}.", Rectangle::square(10));
}

