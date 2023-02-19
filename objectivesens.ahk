#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Ustawienia
RecoilAmount := 5 ; Ustaw poziom kontroli recoilu (im wyższa wartość, tym bardziej kontrolowany recoil)
DelayTime := 10 ; Ustaw czas opóźnienia między ruchami myszki (im wyższa wartość, tym wolniejsze tempo kontrolowania recoilu)
RandomDelay := 50 ; Ustaw maksymalne opóźnienie losowe między ruchami myszki

; Główna pętla
Loop {
    ; Sprawdź, czy przycisk Myszki 3 jest wciśnięty
    if GetKeyState("MButton", "P") {
        ; Ustaw poziom czułości myszki na minimum, aby zapobiec przypadkowemu poruszaniu myszką
        CoordMode, Mouse, Screen
        SetMouseDelay(0)
        SystemParameters("SPI_SETMOUSE", 0, 1) ; Ustaw poziom czułości myszki na minimum

        ; Początkowe ustawienia
        RecoilX := 0
        RecoilY := 0

        ; Symulacja ruchu myszki w górę i w dół
        Loop % RecoilAmount {
            Random, RandomY, -3, 3
            RecoilY := RecoilY + RandomY
            MouseMove, 0, RecoilY, 0, R
            Random, RandomDelay, 0, RandomDelay
            Sleep, DelayTime + RandomDelay
        }

        ; Symulacja ruchu myszki w prawo i w lewo
        Loop % RecoilAmount {
            Random, RandomX, -3, 3
            RecoilX := RecoilX + RandomX
            MouseMove, RecoilX, 0, 0, R
            Random, RandomDelay, 0, RandomDelay
            Sleep, DelayTime + RandomDelay
        }

        ; Resetowanie poziomu czułości myszki do wartości domyślnej
        SystemParameters("SPI_SETMOUSE", 0, 10) ; Ustaw poziom czułości myszki na wartość domyślną
        SetMouseDelay(10)
    }

    ; Sprawdź, czy przycisk Myszki 4 jest wciśnięty
    if GetKeyState("XButton1", "P") {
        ; Zatrzymaj skrypt
        Process, Close, %A_ScriptFullPath%
        ExitApp
    }

    ; Czekaj na wciśnięcie przycisku Myszki 3 lub Myszki 4
    Sleep, 10
}

; Funkcja pomocnicza, zwraca stan klawisza
GetKey(key) {
    state := GetKeyState(key, "P")
    return state
}

; Funkcja pomocnicza, ustawia poziom czułości myszki
SystemParameters(action, value1, value2) {
    SystemParametersInfo, %action%, 0, %value2%, %value1%
}
