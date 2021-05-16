

fn main() {
    println!("Hello, world!");
    // test()
    let  a = 120_i8;

    println!("a : {:?}", a.saturating_add(a));

    let tup = (500, 6.4, 1);

    println!("tup: {:?}", tup);
    let (x,y,z) = tup;
    println!("x: {:?}, {}", x, tup.1);

    let a = [5;3];

    println!("out of range: {}", a[3]);

    let s = "hello";

    let s2 = String::from("hello");

    let s3 = &s2[..];
}

#[derive(Debug)]
struct Demo {
    a: i32,
    b: i32,
}

fn test(){
    let a = 9527;
    let b = 1024;
    let c = String::from("richard");

    let d = Demo{
        a: a,
        b: b,
    };

    println!("let's see a:{}, b:{}, c{},d:{:#?}, d.a:{}", a, b, c, d, d.a);
}