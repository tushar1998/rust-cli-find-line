use clap::Parser;
use std::collections::HashSet;
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

    #[arg(short,long, default_value_t = String::from("package.json"))]
    filename: String,

    #[arg(long, num_args(0..=50), default_values_t=[String::from("node_modules")])]
    exclude_dir: Vec<String>,
}

fn main() {
    let args = Args::parse();

    // println!("{} {} {:?} {:?}!", args.path, args.filename, args.package, args.exclude_dir);

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
    let exclude_dirs: HashSet<_> = args.exclude_dir.iter().cloned().collect(); // Convert to HashSet
    find_file(&path, &file_name, &packages, &exclude_dirs);
}

fn find_file(dir: &Path, filename: &str, packages: &Vec<String>, exclude_dirs: &HashSet<String>) {
    for entry in fs::read_dir(dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();

        if path.is_file() && path.file_name().unwrap() == filename {
            println!("{:?} -> {}", path, entry.file_name().to_str().unwrap());

            let contents = fs::read_to_string(path).unwrap();

            for line in contents.lines() {
                for package in packages.iter() {
                    if line.contains(package) {
                        println!("  -{}", line);
                    }
                }
            }
        } else if path.is_dir()
            && !exclude_dirs.contains(path.file_name().unwrap().to_str().unwrap())
        {
            find_file(&path, filename, packages, exclude_dirs);
        }
    }
}
