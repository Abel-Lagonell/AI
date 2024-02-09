use std::fmt;

#[derive(Debug, Clone)]
pub struct Cell {
    row: u8,
    col: u8,
}

impl Cell{
    pub fn new(row: u8, col: u8) -> Cell{
        Cell{
            row: row, //0 is starting value for A
            col: col, //0 index instead of 1 index
        }
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

pub struct Board {
    placements: Vec<Cell>,//Vector contataining the queen locations
    size: u8
}

impl Board{
    pub fn new(size: u8) -> Board {
        Board{
            placements: Vec::new(),//Start a vector
            size: size //Max size of board
        }
    }

    //Get the vector of queens
    pub fn get_placements(&self) -> &Vec<Cell>{
        &self.placements
    }

    pub fn place_queen(&mut self, row: u8, col: u8) {
        if row > self.size || col > self.size {return}
        self.placements.push(Cell::new(row, col));
        return
    }

    pub fn remove_queen(&mut self) {
        if self.placements.is_empty() {return;}
        self.placements.pop();
    }

    pub fn print_board(&self) {
        let mut board_ = String::new();
        for i in 0..self.size {
            for j in 0..self.size {
                let mut cell_empty = true;
                for queen in &self.placements {
                    if queen.row == i && queen.col == j {
                        board_.push_str("[Q]");
                        cell_empty = false;
                        break;
                    }
                }
                if cell_empty {
                    board_.push_str("[ ]");
                }
            }
            board_.push('\n'); // Add a newline after each row
        }
        println!("{}", board_);
    }
}

//Allow for the displaying of all queens on the board by their coordinate
impl fmt::Display for Board {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let mut cords = "".to_owned();
        for queen in &self.placements{
            cords.push_str(&format!("{}", &queen));
        }
        write!(f, "{}", cords)
    }
}

// returns true if a queen can be placed on a given cell
fn is_safe(board: &Board, cell: &Cell) -> bool {
    // definately safe if there is nothing on board
    if board.get_placements().is_empty() {return true}

    for queen in &board.placements {
        if queen.row == cell.row { return false} 
        if queen.col == cell.col { return false}

        // only do calculations if we need to
        let delta_y: f64 = cell.row as f64- queen.row as f64;
        let delta_x: f64 = cell.col as f64- queen.col as f64;
        let slope : f64 = delta_y/delta_x;
        if slope.abs() == 1.0     { return false}
    }
    return true
}


fn solve_nqueens(board: &mut Board, row: u8) {
    // We are at the last row, so a solution was found
    if row == board.size {board.print_board(); return;}

    for col in 0..board.size {
        if is_safe(board, &Cell::new(row, col)) {
            board.place_queen(row, col);
            // call recursively for next row
            solve_nqueens(board, row + 1);
            // if the recursive call made it to the end, the solution was printed
            // if not, we backtrack and try again
            // even if a solution was found, backtrack all the way to find next one
            board.remove_queen();
        }
    }
}


fn main(){
    let mut q = Board::new(1);
    solve_nqueens(&mut q, 0);    
}
