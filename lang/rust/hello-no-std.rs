#![no_std]
#![no_main]

use core::{arch::asm, convert::TryInto};

unsafe fn syscall_1(num: u64, arg1: u64) -> i64 {
    let res;
    asm!(
        "syscall",
        in("rax") num,
        in("rdi") arg1,
        lateout("rax") res,
    );
    res
}

unsafe fn syscall_3(num: u64, arg1: u64, arg2: u64, arg3: u64) -> i64 {
    let res;
    asm!(
        "syscall",
        in("rax") num,
        in("rdi") arg1,
        in("rsi") arg2,
        in("rdx") arg3,
        lateout("rax") res,
    );
    res
}

fn sys_exit(code: i32) -> ! {
    unsafe {
        syscall_1(60, code as _);
    }
    unreachable!();
}

unsafe fn sys_write(fd: u64, data: *const u8, len: u64) -> i64 {
    syscall_3(1, fd, data as u64, len)
}

fn print(data: &[u8]) -> i64 {
    unsafe { sys_write(1, data.as_ptr(), data.len().try_into().unwrap()) }
}

#[no_mangle]
pub extern "C" fn _start() -> ! {
    print(b"Hello no_std!\n");
    sys_exit(0);
}

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}
