use clap::Parser;
use std::fs::{self};
use std::path::Path;

/// Simple program to greet a person
#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(long, num_args(0..=50))]
    package: Vec<String>,

    #[arg(long, default_value_t = String::from("./"))]
    path: String,

    #[arg(short, default_value_t = String::from("foo"))]
    filename: String,
}

fn main() {
    let args = Args::parse();

    // println!("Hello {} {} {:?}!", args.path, args.filename, args.package);

    // Parameters
    let path = Path::new(&args.path);
    let file_name = String::from(args.filename);

    // Delete the file
    // fs::remove_file("result.txt").unwrap_or_default();

    // create output file
    // let file = OpenOptions::new()
    //     .read(true)
    //     .write(true)
    //     .create(true)
    //     .append(true)
    //     .open("result.txt")
    //     .unwrap();

    let packages = args.package;
    find_file(&path, &file_name, &packages);
}

fn find_file(dir: &Path, filename: &str, packages: &Vec<String>) {
    for entry in fs::read_dir(dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();

        if path.is_file() && path.file_name().unwrap() == filename {
            println!(
                "{:?} -> {}",
                path.parent()
                    .unwrap()
                    .parent()
                    .unwrap()
                    .file_name()
                    .unwrap(),
                entry.file_name().to_str().unwrap()
            );

            let contents = fs::read_to_string(path).unwrap();

            for line in contents.lines() {
                for package in packages.iter() {
                    if line.contains(package) {
                        println!("  -{}", line);
                    }
                }
            }
        } else if path.is_dir() {
            find_file(&path, filename, packages);
        }
    }
}
