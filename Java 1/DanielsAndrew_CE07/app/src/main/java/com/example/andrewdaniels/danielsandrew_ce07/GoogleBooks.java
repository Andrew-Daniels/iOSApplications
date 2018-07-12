package com.example.andrewdaniels.danielsandrew_ce07;

// Andrew Daniels
// JAV1 - C201805
// GoogleBooks.java

public class GoogleBooks {
    private final String title;
    private final String imageURL;

    public GoogleBooks(String title, String imageURL) {
        this.title = title;
        this.imageURL = imageURL;
    }

    public String getTitle() {
        return title;
    }

    public String getImageURL() {
        return imageURL;
    }
}
