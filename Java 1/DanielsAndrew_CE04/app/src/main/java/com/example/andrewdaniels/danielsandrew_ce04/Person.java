package com.example.andrewdaniels.danielsandrew_ce04;
// Andrew Daniels
// JAV1 - C201804
// Person.java
class Person {
    private final String mFirstName;
    private final String mLastName;
    private final String mBirthday;
    private final Integer mProfileImage;

    public Person(String mFirstName, String mLastName, String mBirthday, Integer mProfileImage) {
        this.mFirstName = mFirstName;
        this.mLastName = mLastName;
        this.mBirthday = mBirthday;
        this.mProfileImage = mProfileImage;
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
