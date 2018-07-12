package com.example.andrewdaniels.danielsandrew_ce05;

// Andrew Daniels
// JAV1 - C201804
// Person.java

class Person {
    private final String mFirstName;
    private final String mLastName;
    private final String mBirthday;
    private final Integer mProfileImage;
    private final String mDesc;
    private final String mHobby;


    public Person(String mFirstName, String mLastName, String mBirthday, Integer mProfileImage, String mDesc, String mHobby) {
        this.mFirstName = mFirstName;
        this.mLastName = mLastName;
        this.mBirthday = mBirthday;
        this.mProfileImage = mProfileImage;
        this.mDesc = mDesc;
        this.mHobby = mHobby;
    }

    public String getmDesc() {
        return mDesc;
    }

    public String getmHobby() {
        return mHobby;
    }

    public String getmBirthday() {
        return mBirthday;
    }

    public Integer getmProfileImage() {
        return mProfileImage;
    }

    @Override
    public String toString() {
        return mFirstName + ' ' + mLastName;
    }
}
