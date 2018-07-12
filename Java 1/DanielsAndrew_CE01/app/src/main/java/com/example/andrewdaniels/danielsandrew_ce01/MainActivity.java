package com.example.andrewdaniels.danielsandrew_ce01;

// Andrew Daniels
// JAV1 - C201804
// MainActivity.java

import android.annotation.SuppressLint;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

import java.util.HashMap;

public class MainActivity extends AppCompatActivity {

    private final HashMap<Integer, Character> buttonOptions = new HashMap<>();
    private Button restartButton;
    private Button[] buttons;
    private Button firstButton = null;
    private Button secondButton = null;
    private TextView numberOfFlipsText;
    private Integer numberOfFlips = 0;
    private Integer numberOfMatches = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //Create all UI Elements
        numberOfFlipsText = findViewById(R.id.numberOfGuesses);
        restartButton = findViewById(R.id.restartButton);
        buttons = new Button[] {
                findViewById(R.id.one),
                findViewById(R.id.two),
                findViewById(R.id.three),
                findViewById(R.id.four),
                findViewById(R.id.five),
                findViewById(R.id.six),
                findViewById(R.id.seven),
                findViewById(R.id.eight),
                findViewById(R.id.nine),
                findViewById(R.id.ten),
                findViewById(R.id.eleven),
                findViewById(R.id.twelve),
                findViewById(R.id.thirteen),
                findViewById(R.id.fourteen),
                findViewById(R.id.fifteen),
                findViewById(R.id.sixteen)
        };
        restartButton.setOnClickListener(restartListener);
        for (Button button : buttons) {
            button.setOnClickListener(matchingButton);
        }
        randomizeButtonOptions();
    }

    //Listener for restart button
    private final View.OnClickListener restartListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            //this code will restart the game
            for (Button button: buttons) {
                button.setText("");
                button.setVisibility(View.VISIBLE);
            }
            restartButton.setVisibility(View.INVISIBLE);
            numberOfFlipsText.setText("0");
            randomizeButtonOptions();
        }
    };

    //Listener for when a button is clicked to flip it
    private final View.OnClickListener matchingButton = new View.OnClickListener() {
        @Override
        public void onClick(View v) {

            checkForMaxFlips();
            flipSelection(v);
            checkForMatch();
        }
    };

    //Sets the text value behind the scenes for each button
    private void randomizeButtonOptions() {
        buttonOptions.clear();
        Character[] chars = new Character[] {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'};
        ArrayList<Character> charsList = new ArrayList<>(Arrays.asList(chars));
        ArrayList<Integer> ints = new ArrayList<>();
        Random rand = new Random();
        while(!charsList.isEmpty()) {
            for (int i = 0; i < 2; i++) {
                Integer randomNumber = rand.nextInt(16);
                while (ints.contains(randomNumber)) {
                    randomNumber = rand.nextInt(16);
                }
                ints.add(randomNumber);
                buttonOptions.put(randomNumber, charsList.get(0));
                if (i == 1) {
                    charsList.remove(0);
                }
            }
        }
    }

    @SuppressLint("SetTextI18n")
    //This function will flip the selected button to show it's text value
    private void flipSelection(View v) {
        Button currentBtn = findViewById(v.getId());
        String tag = (String) v.getTag();
        Integer tagInt = Integer.parseInt(tag);
        char currentChar = buttonOptions.get(tagInt);
        String textAsString = Character.toString(currentChar);
        currentBtn.setText(textAsString);
        if (firstButton == null) {
            firstButton = currentBtn;
            numberOfFlips += 1;
        } else if (secondButton == null) {
            if (currentBtn != firstButton) {
                secondButton = currentBtn;
                numberOfFlips += 1;
            }
        }
        Integer numberOfGuesses = (numberOfFlips / 2);
        numberOfFlipsText.setText(numberOfGuesses.toString());
    }

    //This function will make sure there are never more than 2 buttons flipped at once.
    private void checkForMaxFlips() {
        if (firstButton != null && secondButton != null) {
            firstButton.setText("");
            secondButton.setText("");
            firstButton = null;
            secondButton = null;
        }
    }

    //This function checks if the two buttons flipped match.
    private void checkForMatch() {
        if (firstButton != null && secondButton != null) {
            if (firstButton.getText().equals(secondButton.getText())) {
                firstButton.setVisibility(View.INVISIBLE);
                secondButton.setVisibility(View.INVISIBLE);
                numberOfMatches += 1;
                if (numberOfMatches.equals(8)) {
                    restartButton.setVisibility(View.VISIBLE);
                    numberOfMatches = 0;
                    numberOfFlips = 0;
                }
            }
        }
    }


}
