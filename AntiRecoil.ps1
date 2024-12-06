Add-Type -AssemblyName System.Windows.Forms

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class MouseMover {
    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);

    [DllImport("user32.dll")]
    public static extern short GetAsyncKeyState(int vKey);

    public const int VK_X = 0x58;
}
"@

function Move-MouseDown {
    $position = [System.Windows.Forms.Cursor]::Position
    [MouseMover]::SetCursorPos($position.X, $position.Y + 3)  #down by 3 pixels (adjust for smoothness)
}

while ($true) {
    if ([MouseMover]::GetAsyncKeyState([MouseMover]::VK_X) -band 0x8000) {
        Move-MouseDown
    } 
    Start-Sleep -Milliseconds 50  #delay (adjust for speed)
}
