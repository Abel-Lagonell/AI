use std::fmt;

#[derive(Debug, Clone)]
pub struct Cell {
    row: u8,
    col: u8,
}

impl Cell{
    pub fn new() -> Cell{
        Cell{
            row:1,
            col:1,
        }
    }

    pub fn modify(&mut self, row: u8, col:u8){
        self.row = row;
        self.col = col;
    }
}

impl fmt::Display for Cell{
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let ascii = self.row + 64;
        let letter = ascii as char;
        write!(f, "({}, {})", letter, self.col )
    }
}


#[derive(Debug)]
pub struct Queens {
    placements: Vec<Cell>,
    size: usize,
}

impl Queens{
    pub fn new(size: usize) -> Queens {
        Queens{
            placements: vec![Cell::new(); size],
            size: size,
        }
    }

    pub fn test() -> Queens{
        Queens { placements: vec![Cell::new(); 2], size: (2) }
    }

    pub fn get_placements(&self) -> &Vec<Cell>{
        &self.placements
    }

    pub fn check_row_columns(&self, row: u8, col: u8) -> u8{
        let mut count: u8 = 0;
        for queen in self.placements {
            if queen.row == row || queen.col == col{
                count += 1; 
            }
        }
        count
    }

    pub fn check_diagonals(&self, row:u8, col:u8) -> u8{
        let mut count: u8 = 0;
        for queen in self.placements{
            for i in 0..self.size{
                if (queen.row + queen.col == i as u8) && (row + col == i as u8){
                    count += 1;
                }
            }
        }
        count
    }
}

fn main(){
    let q = Queens::test();
    let placements = q.get_placements();
    println!("{}", q.check_row_columns(1, 1));
    println!("{}, {}", placements[0], placements[1])
}
