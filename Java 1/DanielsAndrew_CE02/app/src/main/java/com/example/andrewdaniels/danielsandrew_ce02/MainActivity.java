package com.example.andrewdaniels.danielsandrew_ce02;

// Andrew Daniels
// JAV1 - C201804
// MainActivity.java

import android.content.DialogInterface;
import android.graphics.Color;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Button;
import android.widget.Toast;

import java.util.Random;

public class MainActivity extends AppCompatActivity {

    private TextView[] textViews;
    private String[] arrayOfIntegers;
    private Integer guessesLeft = 4;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //Add all textViews into an array
        textViews = new TextView[]{
                findViewById(R.id.firstEditText),
                findViewById(R.id.secondEditText),
                findViewById(R.id.thirdEditText),
                findViewById(R.id.fourthEditText)
        };
        Button submitGuessesBtn = findViewById(R.id.submitGuessesBtn);
        submitGuessesBtn.setOnClickListener(submitGuessesClick);
        fillArrayOfRandomInts();
    }

    //Handle when user clicks the submitGuess button
    private final View.OnClickListener submitGuessesClick = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if (checkForValidEntriesInTextViews()) {
                Boolean win = true;
                for (TextView textView : textViews) {
                    String tag = (String) textView.getTag();
                    Integer tagInt = Integer.parseInt(tag);


                    final int compare = textView.getText().toString().compareTo(arrayOfIntegers[tagInt]);
                    if (compare < 0) {
                        //guess is less than actual number
                        win = false;
                        textView.setTextColor(Color.BLUE);
                    } else if (compare == 0) {
                        //both are equal
                        textView.setTextColor(Color.GREEN);
                    } else {
                        //guess is greater than actual number
                        win = false;
                        textView.setTextColor(Color.RED);
                    }
                }
                if (win) {
                    //Then present win dialog.
                    //reset game button
                    AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
                    builder.setTitle(R.string.wonMessage);
                    builder.setMessage(R.string.restartMessage);
                    builder.setCancelable(false);
                    builder.setPositiveButton(R.string.restartButton, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            restartGame();
                        }
                    });
                    builder.show();
                } else {
                    decreaseGuessesAndPresentToast();
                }
            } else {
                //Let user know that they need to fill in every blank text view
                Toast.makeText(MainActivity.this, R.string.emptyInputsMessage, Toast.LENGTH_SHORT).show();
            }
        }
    };

    //Create the random numbers that the user needs to guess
    private void fillArrayOfRandomInts() {
        final Random rand = new Random();
        arrayOfIntegers = new String[4];
        for(int i = 0; i < arrayOfIntegers.length; i++) {
            arrayOfIntegers[i] = Integer.toString(rand.nextInt(9));
        }
    }

    //Decrease the amount of guesses the user has and alert user
    private void decreaseGuessesAndPresentToast() {
        guessesLeft -= 1;
        if (guessesLeft > 0) {
            Toast.makeText(this, Integer.toString(guessesLeft) + " GUESSES LEFT", Toast.LENGTH_SHORT).show();
        } else {
            AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
            builder.setTitle(R.string.lost);
            builder.setMessage(R.string.ranOutOfGuesses);
            builder.setPositiveButton(R.string.restartButton, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    restartGame();
                }
            });
            builder.setCancelable(false);
            builder.show();
        }
    }

    //Check that each text view has a valid entry
    private Boolean checkForValidEntriesInTextViews() {
        for (TextView textView: textViews) {
            if(textView.getText().length() == 0) {
                return false;
            }
        }
        return true;
    }

    //Restarts game and presents toast
    private void restartGame() {
        for(TextView textView: textViews) {
            textView.setText("");
            textView.setTextColor(Color.BLACK);
        }
        guessesLeft = 4;
        Toast.makeText(this, Integer.toString(guessesLeft) + " GUESSES LEFT", Toast.LENGTH_SHORT).show();
        textViews[0].setFocusableInTouchMode(true);
        textViews[0].requestFocus();
    }
}
