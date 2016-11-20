package ru.rockyourcode.PigSum;
import android.graphics.Color;
import android.os.Bundle;

import org.qtproject.qt5.android.bindings.QtActivity;

public class MainActivity extends QtActivity
{
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().getDecorView().setBackgroundColor(Color.parseColor("#3F51B5"));
    }
}
