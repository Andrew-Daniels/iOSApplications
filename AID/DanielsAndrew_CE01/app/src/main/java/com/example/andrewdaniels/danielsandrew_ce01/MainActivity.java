package com.example.andrewdaniels.danielsandrew_ce01;

// Andrew Daniels
// AID - C201807
// MainActivity.java



import android.support.constraint.ConstraintLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;

public class MainActivity extends AppCompatActivity {

    private Integer activeLayout = 0;
    private LinearLayout layoutZero;
    private ConstraintLayout layoutOne;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button layoutSwitcher = findViewById(R.id.btn_constraint_layout);
        Button layoutSwitcher2 = findViewById(R.id.btn_linear);

        layoutZero = findViewById(R.id.layoutZero);
        layoutOne = findViewById(R.id.layoutOne);

        layoutSwitcher.setOnClickListener(setLayout);
        layoutSwitcher2.setOnClickListener(setLayout);
    }

    private final Button.OnClickListener setLayout = new Button.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(activeLayout.equals(0)) {
                activeLayout = 1;
                layoutOne.setVisibility(View.VISIBLE);
                layoutZero.setVisibility(View.GONE);
            } else {
                activeLayout = 0;
                layoutZero.setVisibility(View.VISIBLE);
                layoutOne.setVisibility(View.GONE);
            }
        }
    };
}
