# CleanTDDReportTableDemo

This iOS app demonstrates an architectual solution to a fairly complex banking report scene.

This is a slight refactoring of CleanReportTableDemo due to the addition of Unit Tests. In particular it is the testing of the ViewController that has cause the refactoring

It shows how the clean architecture can be used to break up a potentially very Massive View Controller by using the following classes:

a Use Case which transforms its input Model to an output protocol -- there are two transformers: one processes data originating from two separate streams, the other processes data originating from a single stream
a Presenter, which transforms its input Model (the output protcol from the use case) into a ViewModel. The presenter retains the View Model to act as data source for the TableView
Note that the view models used here are not the ViewModels implied by the MVVM pattern
