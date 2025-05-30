use clap::Parser;
// use glob::{glob, glob_with, MatchOptions};
use std::collections::HashSet;
use std::fs::{self};
use std::path::Path;

/// Simple program to greet a person
#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(short, long, num_args(0..=100))]
    keywords: Vec<String>,

    #[arg(short, long, default_value_t = String::from("./"))]
    path: String,

    #[arg(short, long, num_args(0..=50), default_values_t = [String::from("package.json")])]
    filename: Vec<String>,

    #[arg(short, long, num_args(0..=50), default_values_t=[String::from("node_modules")])]
    exclude_dir: Vec<String>,
}

fn main() {
    let args = Args::parse();

    // println!("{} {:?} {:?} {:?}!", args.path, args.filename, args.keywords, args.exclude_dir);

    // Parameters
    let path = Path::new(&args.path);
    let file_name = args.filename;

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

    if !path.exists() {
        println!("Path does not exist - {}", path.display());
        return;
    }

    let keywords = args.keywords;
    let exclude_dirs: HashSet<_> = args.exclude_dir.iter().cloned().collect();
    find_file(path, &file_name, &keywords, &exclude_dirs);
}

fn find_file(
    dir: &Path,
    filenames: &Vec<String>,
    keywords: &Vec<String>,
    exclude_dirs: &HashSet<String>,
) {
    for entry in fs::read_dir(dir).unwrap() {
        let entry = entry.unwrap();
        let path = entry.path();

        if path.is_file() {
            for filename in filenames {
                if path.file_name().unwrap().to_str().unwrap() == filename {
                    println!("{:?} -> {}", path, entry.file_name().to_str().unwrap());
                    let contents = fs::read_to_string(&path).unwrap();

                    for line in contents.lines() {
                        for word in keywords.iter() {
                            if line.contains(word) {
                                println!("  -{}", line);
                            }
                        }
                    }
                }
            }
        } else if path.is_dir()
            && !exclude_dirs.contains(path.file_name().unwrap().to_str().unwrap())
        {
            find_file(path.as_path(), filenames, keywords, exclude_dirs);
            // println!(" ")
        }
    }
}
