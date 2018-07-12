package com.example.andrewdaniels.danielsandrew_ce03;

//Andrew Daniels
//AID - C201807
//MainActivity.java

import android.graphics.Typeface;
import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Switch;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private RadioGroup bCGRdoGrp;
    private RadioGroup tCRdoGrp;

    private EditText etInput;
    private TextView tvOutput;

    private FrameLayout frameLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setTheme(R.style.CustomTheme);
        setContentView(R.layout.activity_main);

        bCGRdoGrp = findViewById(R.id.backgroundColorRadioGroup);
        tCRdoGrp = findViewById(R.id.textColorRadioGroup);

        etInput = findViewById(R.id.et_inputField);
        tvOutput = findViewById(R.id.tv_output);
        Switch isBoldSwitch = findViewById(R.id.textStyle_switch);

        frameLayout = findViewById(R.id.frameLayout);

        bCGRdoGrp.setOnCheckedChangeListener(colorChange);
        tCRdoGrp.setOnCheckedChangeListener(colorChange);
        etInput.addTextChangedListener(textChanged);
        isBoldSwitch.setOnCheckedChangeListener(styleChange);
    }

    private final TextWatcher textChanged = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {

        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
            tvOutput.setText(etInput.getText());
        }

        @Override
        public void afterTextChanged(Editable s) {

        }
    };

    private final Switch.OnCheckedChangeListener styleChange = new Switch.OnCheckedChangeListener() {
        @Override
        public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
            changeStyle(isChecked);
        }
    };

    private final RadioGroup.OnCheckedChangeListener colorChange = new RadioGroup.OnCheckedChangeListener() {
        @Override
        public void onCheckedChanged(RadioGroup group, int checkedId) {
            RadioButton checkedRdoBtn = group.findViewById(checkedId);
            String rdoBtnTextAsString = checkedRdoBtn.getText().toString();
            if (group.equals(bCGRdoGrp)) {
                changeColorOfElement(false, rdoBtnTextAsString);
            } else if (group.equals(tCRdoGrp)) {
                changeColorOfElement(true, rdoBtnTextAsString);
            }
        }
    };

    private void changeColorOfElement(Boolean isTextView, String rdoBtnTextAsString) {
        int color;
        switch (rdoBtnTextAsString) {
            case "Purple":
                color = getResources().getColor(R.color.Purple);
                break;
            case "Green":
                color = getResources().getColor(R.color.Green);
                break;
            default:
                color = getResources().getColor(R.color.Black);
                break;
        }
        if (isTextView) {
            tvOutput.setTextColor(color);
        } else {
            frameLayout.setBackgroundColor(color);
        }
    }

    private void changeStyle(Boolean isBold) {
        if (isBold) {
            tvOutput.setTypeface(null, Typeface.BOLD);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                tvOutput.setTextAppearance(R.style.TextStyle_On);
            } else {
                tvOutput.setTextAppearance(null, R.style.TextStyle_On);
            }
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                tvOutput.setTextAppearance(R.style.TextStyle_Off);
            } else {
                tvOutput.setTextAppearance(null, R.style.TextStyle_Off);
            }
        }
    }
}
