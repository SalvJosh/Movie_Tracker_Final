-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/JoMRW2
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "User" (
    "ID" SERIAL   NOT NULL,
    "Username" VARCHAR(20)   NOT NULL,
    "Email" VARCHAR(120)   NOT NULL,
    "Password" VARCHAR(60)   NOT NULL,
    CONSTRAINT "pk_User" PRIMARY KEY (
        "ID"
     )
);

CREATE TABLE "Movie" (
    "ID" SERIAL   NOT NULL,
    "Title" VARCHAR(100)   NOT NULL,
    "Year" VARCHAR(10)   NOT NULL,
    "Poster" VARCHAR(300)   NOT NULL,
    "Watched" BOOLEAN   NOT NULL,
    "Added_at" TIMESTAMP   NOT NULL,
    "User_id" INTEGER   NOT NULL,
    CONSTRAINT "pk_Movie" PRIMARY KEY (
        "ID"
     )
);

ALTER TABLE "User" ADD CONSTRAINT "fk_User_ID" FOREIGN KEY("ID")
REFERENCES "Movie" ("ID");

