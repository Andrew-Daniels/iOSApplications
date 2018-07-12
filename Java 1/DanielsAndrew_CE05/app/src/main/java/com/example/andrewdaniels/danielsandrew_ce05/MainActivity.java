package com.example.andrewdaniels.danielsandrew_ce05;

// Andrew Daniels
// JAV1 - C201804
// MainActivity.java

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private ListView mListView;
    private TextView name_Label;
    private TextView birth_Label;
    private TextView hobby_Label;
    private TextView desc_Label;
    private Spinner namePkr;
    private ImageView image;
    private final ArrayList<Person> mPeople = new ArrayList<>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Assign all views to their perspective variables
        mListView = findViewById(R.id.person_listview);
        name_Label = findViewById(R.id.name_textview);
        birth_Label = findViewById(R.id.birth_textview);
        hobby_Label = findViewById(R.id.hobby_textview);
        desc_Label = findViewById(R.id.desc_textview);
        image = findViewById(R.id.profile_image);
        namePkr = findViewById(R.id.person_spinner);

        mListView.setOnItemClickListener(personSelected);
        namePkr.setOnItemSelectedListener(personSelectedSpinner);

        populateDataCollection();
        setupAdapter();

        if (mListView.getVisibility() != View.GONE) {
            selectAPersonAtPosition(0);
        }
    }

    //Item Click Listener for ListView.
    //Displays the information for the selected person
    private final ListView.OnItemClickListener personSelected = new ListView.OnItemClickListener() {
        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            selectAPersonAtPosition(position);
            namePkr.setSelection(position);
        }
    };

    //Item Selected Listener for Spinner
    //Displays the information for the selected person
    private final Spinner.OnItemSelectedListener personSelectedSpinner = new Spinner.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            selectAPersonAtPosition(position);
        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {

        }
    };

    //Function that populates the data collection with data.
    private void populateDataCollection() {
        String[] descArray = getResources().getStringArray(R.array.descriptions);
        mPeople.add(new Person("Bob", "Marley", "04/14/1983", R.drawable.image_1, descArray[0], "Sewing"));
        mPeople.add(new Person("Suit", "Aleo", "12/14/1793", R.drawable.image_2, descArray[1], "Skateboarding"));
        mPeople.add(new Person("Onet", "Ime", "05/14/1893", R.drawable.image_3, descArray[2], "Dishes"));
        mPeople.add(new Person("Inb", "Andca", "11/24/1994", R.drawable.image_4, descArray[3], "Jumping Jacks"));
        mPeople.add(new Person("Mpi", "Wen", "02/13/1944", R.drawable.image_5, descArray[4], "Skiing"));
        mPeople.add(new Person("To", "Schoo", "07/20/1920", R.drawable.image_6, descArray[5], "Flying"));
        mPeople.add(new Person("Lbut", "Ididnt", "10/13/1953", R.drawable.image_7, descArray[6], "Travel"));
        mPeople.add(new Person("Makei", "Tback", "06/03/1997", R.drawable.image_8, descArray[7], "Technology"));
        mPeople.add(new Person("Hom", "Eont", "09/06/1973", R.drawable.image_9, descArray[8], "Computers"));
        mPeople.add(new Person("Imes", "Oiwa", "10/13/2000", R.drawable.image_10, descArray[9], "Photography"));
    }

    //This function will fill the UI Elements with the selected person's data.
    private void selectAPersonAtPosition(int position) {
        final Person selectedPerson = mPeople.get(position);
        name_Label.setText(selectedPerson.toString());
        birth_Label.setText(selectedPerson.getmBirthday());
        hobby_Label.setText(selectedPerson.getmHobby());
        desc_Label.setText(selectedPerson.getmDesc());
        image.setImageResource(selectedPerson.getmProfileImage());
    }

    //This function will setup the adapter and assign itself to the spinner and listview
    private void setupAdapter() {

        ArrayAdapter<Person> spinnerAdapter = new ArrayAdapter<>(
                this,
                android.R.layout.simple_list_item_1,
                mPeople
        );

        PersonAdapter listViewAdapter = new PersonAdapter(this, mPeople, R.layout.listview_person_layout1);

        mListView.setAdapter(listViewAdapter);
        namePkr.setAdapter(spinnerAdapter);
    }
}
