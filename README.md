# CleanTDDReportTableDemo

This iOS app demonstrates an architectual solution to a fairly complex banking report scene. It shows how the VIPER can be used to break up a potentially very Massive View Controller. 

This demonstation app shows how Test Driven Development (TDD) can be applied to write even cleaner code than would be written without TDD. 

Besides the addition of tests, this is demo is a slight refactoring of CleanReportTableDemo due to the application of TDD.

Testing a ViewController is normally pretty complicated. The use of VIPER makes testing a view controller very straightforward. 

Besides the Adapter, Presenter, UseCase and Transformer classes that were introduced in CleanReportTableDemo, new classes have been added to make Unit Testing simpler.

The Adapter has been further refactored to produce the CellConfigurator.  The CellConfigurator is an *object method* used to test the cells delivered by the tableView. 

EntityManagers have been introduced to make it simpler to test the Transformers. The EntityGateway now only contains properties pointing to EntityManagers. The Respsonsibility of fetching data is moved from the gateway to the managers. The Transformers now take their input data directly as arguments.


