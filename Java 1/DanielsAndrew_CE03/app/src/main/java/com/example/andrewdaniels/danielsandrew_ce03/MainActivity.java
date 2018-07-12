package com.example.andrewdaniels.danielsandrew_ce03;

// Andrew Daniels
// JAV1 - C201804
// MainActivity.java

import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.NumberPicker;
import android.widget.TextView;
import android.widget.Toast;

import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private final ArrayList<String> listOfWords = new ArrayList<>();
    private EditText addWordTextField;
    private NumberPicker wordPkr;
    private TextView averageLabel;
    private TextView medianLabel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Create objects for each UI Element
        Button addBtn = findViewById(R.id.addBtn);
        Button viewBtn = findViewById(R.id.viewBtn);
        addWordTextField = findViewById(R.id.addWordTextField);
        averageLabel = findViewById(R.id.averageWordValue);
        medianLabel = findViewById(R.id.medianWordValue);

        wordPkr = findViewById(R.id.wordPicker);

        //Set the click listeners for the add and view button
        addBtn.setOnClickListener(addBtnClicked);
        viewBtn.setOnClickListener(viewBtnClicked);
    }

    private final View.OnClickListener addBtnClicked = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            //Check for valid word entry
            if (checkForValidEntry()) {

                //Add word to list & update the numberPicker
                addWordToList();
                averageLabel.setText(findAverage());
                medianLabel.setText(findMedian().toString());
            } else {
                //Give Toast for invalid word here
                if (addWordTextField.getText().toString().isEmpty()) {
                    Toast.makeText(MainActivity.this, R.string.emptyFieldMessage, Toast.LENGTH_SHORT).show();
                }
                else if (addWordTextField.getText().toString().trim().isEmpty()) {
                    Toast.makeText(MainActivity.this, R.string.blankSpacesMessage, Toast.LENGTH_SHORT).show();
                }
            }
        }
    };

    //Show user the word they selected, handle remove word button click here also
    private final View.OnClickListener viewBtnClicked = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            final AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
            builder.setTitle(R.string.wordSelected);
            builder.setCancelable(true);
            builder.setPositiveButton(R.string.closeBtn, null);
            if (listOfWords.size() > 0) {
                final Integer selectedWordIndex = wordPkr.getValue() - 1;
                final String wordSelected = listOfWords.get(selectedWordIndex);


                builder.setMessage(wordSelected);

                builder.setNeutralButton(R.string.removeWordBtn, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        //Remove the word from list then reload the number picker
                        listOfWords.remove(wordSelected);
                        if (listOfWords.size() > 0) {
                            averageLabel.setText(findAverage());
                            medianLabel.setText(findMedian().toString());
                        } else {
                            averageLabel.setText("0");
                            medianLabel.setText("0");
                        }
                        updateNumberPicker();
                    }
                });
            } else {
                builder.setMessage(R.string.noWordsLeft);
            }
            builder.show();
        }
    };

    //Check if the word entered is valid
    private Boolean checkForValidEntry() {
        return !addWordTextField.getText().toString().trim().isEmpty();
    }

    private void addWordToList() {
        //Add word to the ArrayList
        final String enteredWord = addWordTextField.getText().toString();
        final Integer indexToPlaceWord = listOfWords.size();
        addWordTextField.setText("");
        listOfWords.add(indexToPlaceWord, enteredWord);

        //once word is added to list update the number picker
        updateNumberPicker();
    }

    //Find the average length of each word in list
    private String findAverage() {
        final Double[] arrayOfWordLengths = createSortedArrayOfWordLengths();
        Double average = 0.00;
        for (Double oneLength: arrayOfWordLengths) {
            average += oneLength;
        }
        average = average / arrayOfWordLengths.length;
        DecimalFormat df = new DecimalFormat("#.0#");
        return df.format(average);

    }

    //Find the median length for the words in the list
    private Double findMedian() {
        final Double[] arrayOfWordLengths = createSortedArrayOfWordLengths();

        int middle = arrayOfWordLengths.length / 2;

        if (arrayOfWordLengths.length % 2 == 1) {
            return arrayOfWordLengths[middle];
        }
        return (arrayOfWordLengths[middle - 1] + arrayOfWordLengths[middle]) / 2.0;
    }

    //Create the Array for the word lengths entered by the user
    private Double[] createSortedArrayOfWordLengths() {
        Double[] doubles = new Double[listOfWords.size()];
        for(int i = 0; i < listOfWords.size(); i++) {
            doubles[i] = listOfWords.get(i).length() * 1.0;
        }
        Arrays.sort(doubles);
        return doubles;
    }

    //Update the number picker with the values it should display
    private void updateNumberPicker() {
        String[] tempStringArray = new String[listOfWords.size()];

        for(Integer i = 0; i < listOfWords.size(); i++) {
            tempStringArray[i] = i.toString();
        }

        wordPkr.setDisplayedValues(null);
        if (tempStringArray.length == 0) {
            wordPkr.setMinValue(0);
            wordPkr.setMaxValue(0);
        } else {
            wordPkr.setMinValue(1);
            wordPkr.setMaxValue(tempStringArray.length);
            wordPkr.setDisplayedValues(tempStringArray);
        }
    }
}
