package com.example.andrewdaniels.danielsandrew_ce08;

import android.content.res.Configuration;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;

// Andrew Daniels
// JAV1 - C201805
// MainActivity.java

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private class ViewHolder {
        public EditText etUserInput;
        public Button btnSubmit;
        public ListView uiListView;
        public ArrayList<String> listOfUserInputs = new ArrayList<>();
    }
    private static final String LOG_TAG = "MAINACTIVITY_CE08";
    private static final String SAVE_KEY_USERINPUT = "SAVE_KEY_ACTIVITY_USERINPUT";
    private ViewHolder mViewHolder = new ViewHolder();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        setupActivity();
    }

    //Setup the MainActivity with the correct layout dependant on device orientation.
    private void setupActivity() {
        try {
            Configuration config = getResources().getConfiguration();

            if (config.orientation == Configuration.ORIENTATION_PORTRAIT) {
                setContentView(R.layout.activity_main_portrait);
            } else if (config.orientation == Configuration.ORIENTATION_LANDSCAPE) {
                setContentView(R.layout.activity_main_landscape);
            }
        } catch (Exception e) {
            Log.i(LOG_TAG, "--> setupActivity() \n" + e);
        }

        try {
            mViewHolder.etUserInput = findViewById(R.id.etUserInput);
            //mViewHolder.listOfUserInputs =
            mViewHolder.uiListView = findViewById(R.id.uiListView);
            mViewHolder.btnSubmit = findViewById(R.id.btnSubmit);
            mViewHolder.btnSubmit.setOnClickListener(this);
        } catch (Exception e) {
            Log.i(LOG_TAG, "--> setupActivity() \n" + e);
        }
    }

    //When submit button is clicked
    //Check if text views are empty
    //Otherwise add string to list view
    public void onClick(View var1) {
        if(var1.getId() == R.id.btnSubmit) {
            try {
                String userInputString = mViewHolder.etUserInput.getText().toString();
                if (!userInputString.trim().equals("")) {
                    mViewHolder.listOfUserInputs.add(userInputString);
                    setListViewAdapter();
                } else if (userInputString.equals("")) {
                    //Give toast to let user know empty string is not allowed.
                    Toast.makeText(MainActivity.this, "Input is empty.", Toast.LENGTH_SHORT).show();
                } else {
                    Toast.makeText(MainActivity.this, "Input cannot be just spaces.", Toast.LENGTH_SHORT).show();
                }
                mViewHolder.etUserInput.setText("");
            }
            catch (Exception e) {
                Log.e(LOG_TAG, "onClick() \n" + e);
            }
        }
        else {
            Log.i(LOG_TAG, "onClick() Unhandled ID " + var1.getId() +
                    ", expecting ID " + R.id.btnSubmit);
        }
    }

    //Set the adapter for the list view
    private void setListViewAdapter() {
        ArrayAdapter<String> listViewAdapter = new ArrayAdapter<> (
                this,
                android.R.layout.simple_list_item_1,
                mViewHolder.listOfUserInputs

        );

        mViewHolder.uiListView.setAdapter(listViewAdapter);
    }

    //Retrieve the saved data from Bundle object
    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        Log.i(LOG_TAG, "----> onRestoreInstanceState()");
        super.onRestoreInstanceState(savedInstanceState);

        try {
            mViewHolder.listOfUserInputs = savedInstanceState.getStringArrayList(SAVE_KEY_USERINPUT);
            if (mViewHolder.listOfUserInputs.size() > 0) {
                setListViewAdapter();
            }
        } catch (Exception e) {
            Log.e(LOG_TAG, "onRestoreInstanceState() \n" + e);
        }
    }

    //Save data to bundle object to retrieve later.
    @Override
    public void onSaveInstanceState(Bundle outState) {
        Log.i(LOG_TAG, "----> onSaveInstanceState()");
        super.onSaveInstanceState(outState);

        try {
            outState.putStringArrayList(SAVE_KEY_USERINPUT, mViewHolder.listOfUserInputs);

        } catch (Exception e) {
            Log.e(LOG_TAG, "onSaveInstanceState() \n" + e);
        }
    }
}
