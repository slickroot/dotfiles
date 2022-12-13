from typing import List
from kitty.boss import Boss

def main(args: List[str]) -> str:
    # this is the main entry point of the kitten, it will be executed in
    # the overlay window when the kitten is launched
    title = input('Enter title for the new tab: ')
    # whatever this function returns will be available in the
    # handle_result() function
    return title

def handle_result(args: List[str], title: str, target_window_id: int, boss: Boss) -> None:
    # get the kitty window into which to paste answer
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        tm = boss.active_tab_manager
        if tm is not None:
            tm.new_tab().set_title(title)
