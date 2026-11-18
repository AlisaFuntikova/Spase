#include <Windows.h>
#include "LoadGame.h"

int main() {
    SetConsoleOutputCP(CP_UTF8);
    SetConsoleCP(CP_UTF8);
    LoadGame game;
    game.start();

    return 0;
}
