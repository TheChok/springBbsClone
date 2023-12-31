package com.bbs.domain;

public class Person {

    private String name;
    private int age;

    public Person(){}
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    
    //-- Gettter n Setter --//
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getAge() {
        return age;
    }
    public void setAge(int age) {
        this.age = age;
    }
    //-- End of Gettter n Setter --//


    @Override
    public String toString() {
        return "Person{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}