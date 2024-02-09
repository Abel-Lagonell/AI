use std::{fmt, ops::{Index, IndexMut}};

#[derive(Debug, Clone)]
pub struct Cell {
    row: u8,
    col: u8,
    max: usize,
}

impl Cell{
    pub fn new(max: usize) -> Cell{
        Cell{
            row: 0, //0 is starting value for A
            col: 0, //0 index instead of 1 index
            max: max, //The max any of the two values could be
        }
    }

    //Modifies the row and column of the cell
    pub fn modify(&mut self, row: u8, col:u8){
        if row > self.max as u8 || col > self.max as u8 {return}
        self.row = row;
        self.col = col;
    }
}

// Alows the cell to display in coordinate form
impl fmt::Display for Cell{
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let ascii = self.row + 65;
        let letter = ascii as char;
        write!(f, "({}, {})", letter, (self.col + 1))
    }
}

pub struct Queens {
    placements: Vec<Cell>,//Vector contataining the queen locations
    _size: usize, //Size of the grid
}

impl Queens{
    pub fn new(size: usize) -> Queens {
        Queens{
            placements: vec![Cell::new(size); size],
            _size: size,
        }
    }

    //For quick testing purposes, makes a cell with 4x4 'grid'
    pub fn test() -> Queens{
        Queens { placements: vec![Cell::new(4); 4], _size: (4) }
    }

    //Get the vector of queens
    pub fn get_placements(&self) -> &Vec<Cell>{
        &self.placements
    }

    //Get back the number of queens in a similar row, column, or diagonals
    pub fn count_queens(&self, row: u8, col: u8) -> u8{
        let mut count: u8 = 0;
        for queen in &self.placements {
            let delta_y: f64 = row as f64- queen.row as f64;
            let delta_x: f64 = col as f64- queen.col as f64;
            let slope : f64 = delta_y/delta_x;
            if slope == 1.0     { count += 1; continue;}
            if slope == -1.0    { count += 1; continue;}
            if queen.row == row { count += 1; continue;} 
            if queen.col == col { count += 1; continue;}
        }
        count
    }
}

//Allow for the displaying of all queens on the board by their coordinate
impl fmt::Display for Queens {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let mut cords = "".to_owned();
        for queen in &self.placements{
            cords.push_str(&format!("{}", &queen));
        }
        write!(f, "{}", cords)
    }
}

//These I think can be deleted once testing is done
//These two functions are for easier getting of the queens 
impl Index<usize> for Queens{
    type Output = Cell;

    fn index(&self, index: usize) -> &Self::Output {
        &self.placements[index]
    }
}

impl IndexMut<usize> for Queens{
    fn index_mut(&mut self, index: usize) -> &mut Cell {
        &mut self.placements[index]
    }
}


fn main(){
    let mut q = Queens::test();
    q[0].modify(0, 1);
    q[1].modify(1, 3);
    q[2].modify(2, 0);
    q[3].modify(3, 2);
    println!("{}", q.count_queens(0, 1));
    println!("{}", q);
}
