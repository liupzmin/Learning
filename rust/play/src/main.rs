use std::fs;
use std::fs::File;
use std::io;
use std::io::Read;

fn main() {
    println!("Hello, world!");
    // test()
    // let  a = 120_i8;
    //
    // println!("a : {:?}", a.saturating_add(a));
    //
    // let tup = (500, 6.4, 1);
    //
    // println!("tup: {:?}", tup);
    // let (x,y,z) = tup;
    // println!("x: {:?}, {}", x, tup.1);
    //
    // let a = [5;3];
    //
    // // println!("out of range: {}", a[3]);
    //
    // let s = "hello";
    //
    // let s2 = String::from("hello");
    //
    // let s3 = &s2[..];
    //
    //
    // let mut tmut = 3;
    // let tt = &mut tmut;
    //
    // let tms = Tm(10);
    // test_tm(tms);

}

struct Tm (i32);

fn read_username_from_file() -> Result<String, io::Error> {
    let f = File::open("hello.txt");
    let mut f = match f {
        Ok(file) => file,
        Err(e) => return Err(e),
    };

    let mut s = String::new();

    match f.read_to_string(&mut s) {
        Ok(_) => Ok(s),
        Err(e) => Err(e),
    }
}

fn read_username_from_file_question_mark () -> Result<String, io::Error> {
    let mut f = File::open("hello.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}

fn read_username_from_file_question_mark_2 () -> Result<String, io::Error> {
    fs::read_to_string("hello.txt")
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

fn test_tm(mut a: Tm) {
    a.0 = 10;
    println!("{}",a.0)
}