#[derive(Debug, Clone)]
pub struct Cell {
    row: u8,
    col: u8,
}

impl Cell{
    pub fn new() -> Cell{
        Cell{
            row:0,
            col:0,
        }
    }

    pub fn modify(&mut self, row: u8, col:u8){
        self.row = row;
        self.col = col;
    }
}


#[derive(Debug)]
pub struct Board {
    board: Vec<Cell>,
}

impl Board{
    pub fn new(size: usize) -> Board {
        Board{
            board: vec![Cell::new(); size],
        }
    }


}

fn main(){
    print!("Hello World");
}
