********************

## Goals

Tenets of good application design in CFML context.

Knowing how to "plan" for refactoring.

Frameworks/patterns as *tools* _not_ *obstacles*.

Learning to be "okay" with moving on w/development.

Learning new stuff can be difficult--this session strives to cover things that can provide a big ROI of learning time.

********************

## Application Design: "10,000-foot view"

MVC:
architectural pattern to isolate business logic from user interface

DI:
allows a software component to list dependencies, and a DI framework handles the dependency resolution (DI is a specific form of the IoC principle)

ORM:
abstracts persistence of objects (CFC instance data) to relational database

AOP:
increase modularity and decrease coupling by allowing for separation of cross-cutting concerns

********************

## Sample Application Overview

**Expectations/Disclaimers:**

* Variety of topics: wide, yet related
* Depth of topics: shallow individually, yet rich and powerful collectively
* Tools: excellent choices, but not the only choices
* Examples: directly useful, but not the only way
* At end we'll review how/when to "break the rules" and refactor later

********************

## DEMO: Sample Application

Browser preview of branch:
presentation_cfObjective-2011

********************

## Model-View-Controller (MVC)

MVC separation of concerns permitting independent development, testing and maintenance of each (Model/View).

********************

## MVC with Framework One (FW/1)

Heavy list for one slide, but good highlights to intro FW/1.

**Briefly** explain each point.

********************

## FW/1 Convention: Request Action

How to make a request of the framework--note nomenclature for later discussion:
action --> section and item

********************

## FW/1 Convention: File Organization

layouts == main display layout template(s)

views == body markup and other "pods" of display output

controllers == framework/request-"aware" CFCs

Review example screen shot directory structures, referencing action=section.item from prior slide.

********************

## FW/1 Convention: Request Context

RC is basically data *from* user/request and data *to* views/layouts/response.

********************

## FW/1 Convention: Request Flow-1/2

********************

## FW/1 Convention: Request Flow-2/2

Discuss implicit service calls by FW/1, and setting to turn off.

********************

## FW/1 Configuration, Application.cfc

********************

## DEMO: FW/1 Basics

**demo_01_FW1-basics**

**Walk through action=main.default:**

* Application.cfc
* Browser: home page
* layouts/default.cfm
* views/main/default.cfm
* controllers/main.cfc

********************

## Model

Your focus should be on domain objects as most important part of OOP design.

Data access is just that.

Service layer basics--more covered later.

********************

## Model: Domain/Business Objects

********************

## Model: Data Access Layer

********************

## Model: Service Layer

********************

## Persistence: CFML/Hibernate ORM

ORM can be overwhelming to the uninitiated, but it has big ROI potential!

Think about domain model objects and good OOP principles--not database.

********************

## ORM Configuration

********************

## ORM Entities

********************

## ORM CRUD

********************

## Importance of ORM Transactions

********************

## DEMO: ORM, Service/Data Layers

**demo_02_orm-service-data-basics**

* Application.cfc
* Abbreviation.cfc
* Definition.cfc
* AbbreviationService.cfc
* AbbreviationGateway.cfc
* Browser: home page
* action=main.default: layout, view, controller, service, gateway
* action=abbreviation.define: view, controller, service, gateway
* action=abbreviation.submit: controller, service, gateway

********************

## Questions? (Part 2, after a short break...)

**Covered So Far:**

* MVC
* Model: domain objects, data access, services
* FW/1
* ORM

********************

## ValidateThis for CFC Validation

********************

## ValidateThis, Quick Start

********************

## ValidateThis Rules Definition

********************

## DEMO: ValidateThis

**demo_03_ValidateThis**

* Browser: demo validation failures
* Application.cfc
* Abbreviation.xml
* Definition.xml
* AbbreviationService.cfc: saveAbbreviation()/saveDefinition()

********************

## ColdSpring Framework

********************

## ColdSpring: Beans Definition

********************

## ColdSpring: Bean Factory

********************

## DEMO: ColdSpring DI

**demo_04_ColdSpringDI**

* beans.xml
* AbbreviationService.cfc properties: abbreviationGateway, validationService

********************

## Abstract Gateway/Service for ORM

********************

## DEMO: Abstract Gateway/Service

**demo_05_AbstractGateway**

* AbstractGateway.cfc
* oMM tricks/"API"
* AbbreviationService.cfc

**demo_06_AbstractService**

* AbstractService.cfc: get/list methods all removed
* onMM "API"/passthrough
* Controllers -- calling missing service methods ;-)

********************

## ColdSpring AOP for Transaction Advice

********************

## DEMO: AOP Transaction Advice

**demo_07_AOPTransactionAdvice**

* beans.xml
* TransactionAdvice.cfc
* AbbreviationService.cfc: transactions removed


********************

## Abstract Base CFCs

********************

## DEMO: Abstract Persistent Entity

**demo_08_AbstractPersistentEntity**

* AbstractPersistentEntity and slimmed down beans

********************

## Unit Testing with MXUnit

********************

## DEMO: MXUnit unit testing

**demo_09_MXUnitTesting**

* Review /tests directory structure
* Browser: /tests/unit/index.cfm -- show test suite run
* AbstractTestCase.cfc
* Review each test case CFC--*briefly*

********************

## Review: Big Picture

********************

## Review: Down w/Design Paralysis!

********************

## Questions?

* Code on GitHub: https://github.com/jamiekrug/notintothewholebrevitything/tree/presentation_cfObjective-2011
* Hallway/lunch questions or discussion
* Feedback survey (4 questions) on cfObjective.com session page

********************











********************

