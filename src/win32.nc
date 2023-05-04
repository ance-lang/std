private define Handle alias ptr;
private define Bool alias i32;

private consume_last_error (ok: Bool) 
{
    if ok /= 0 then return;
    
    let error := GetLastError();
    assert false; // Currently, no actual error handling is done. This functions servers as a marker that errors are ignored.
}

// All the extern functions are provided by the system libraries that are linked by default:

extern WriteFile (hFile: Handle, lpBuffer: *u8, nNumberOfBytesToWrite: u32, lpNumberOfBytesWritten: *u32, lpOverlapped: ptr) : Bool;
extern GetStdHandle (nStdHandle: u32) : Handle;
extern SetConsoleOutputCP (wCodePageID: u32) : Bool;
extern GetLastError () : u32;
