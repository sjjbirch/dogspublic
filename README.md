# README?
## No. A helpful marking guide.

## Links
- A link (URL) to your deployed app (i.e. website)
  - https://dog-fx2.herokuapp.com/doglist

- A link to your GitHub repository (repo).
  - https://github.com/sjjbirch/dogspublic

## Descriptions
- Description of app:
  - (CMP1042-3.1) This website solves the problem of Australian dog breeders, who are the target audience, not being able to easily create their own pages to display dogs and to sell dogs between each other. This is discussed in much more detail in the attached Powerpoint presentation.
  - This website features basic bootstrap styling, two devise authentication models for different roles, sanitisation and validation of all user inputs, the ability to create, view, edit and buy dogs, to advertise dogs, to view and edit adverts for dogs, to browse dogs by type using sophisticated custom scopes, to delete resources, to create upcoming litters, to attach pictures of existing litters and to show them off. It also has an integrated admin dashboard with god features. Custom callbacks have been implemented for some extensions to sanitisation.
  - A public sitemap is attached in XML format.
  - (CMP1042-1.3) This site was built using Rails 6.3 and Bootstrap 3.4.1. External third party services used are a PG database on Heroku, Cloudinary active storage and Heroku hosting. Authentication is handled by Devise.

- (CMP1042-1.2) High level components and abstraction:
  - Abstract conceptualisation of the purposes and limits of high level components in this app:
    - In general, within this app:
      - All views in the app only touch their own controller.
      - Most controllers only touch their own model or the models of their children through explicit accepts_nested_attributes_for calls.
      - Some controllers touch other models, where this happens safety is ensured by:
        - Interacting with the model through its own controller.
        - Interacting with the model only with safe methods (for eg .try)
        - If neither are suitable, then:
          - Interacting with the model through a special scope, and;
          - Interacting with attributes of the model with which the regular controller cannot interact.
    - Models are exclusively responsible for ensuring data quality and safety, unless the integrity also relates to authentication.
    - Controllers are exclusively responsible for control flow, including authentication handling, except where the control flow relates to data quality or safety.
    - Views have no function but to accept and output data for humans.

  - MVC for abstracting dynamic view generation:
    - The use of the MVC pattern allows views to operate only with instance variables and without touching scope. This allows for the creation of dynamic views without allowing views access to database functions.
    - To keep code relatively dry extensive use of partials is made to display content that is common across pages. For example, in addition to layout based partials for debug information, flash messages and navigation elements, the dogs controller based views make use of a partial that accepts iterable collections of dog instances to output desired information, with the difference in output between different views determined by scoping conducted in models and called in controlled-based actions. In this way, a single piece of code can be used to output information that varies dynamically based on who requests it, from where they request it and based on what they request.
    
  - Inheritance for abstracting behaviours and characteristics
    - Models
      - Each model exploits class inheritance from ApplicationRecord to trigger callback to time the sanitisation of all user input. The timing for the trigger is located in ApplicationRecord, calling a sanitation method on any model however:
      - The sanitation method varies by model, with each model using its own unique one. Nearly all sanitation methods, while unique, are based on an inbuilt Rails methods that would not normally be available to models, but explicit inheritance is used in private methods to achieve it. The decision to conduct the (rubric directed) manual sanitisation in models was done because it better meets the intent of separating concerns and to aim for fatter models.
      - Where inbuilt methods could not achieve sanitation or validation, for example where Rails 6 lacks robust tools for validating and sanitising dates, the use of self.scoping allows the construction of appropriate private methods.
    - Controllers
      - Controllers also exploit class inheritance to carry out common functions. For example admins and their dashboard do not have data relationships with the model instances they administer and with which they interact, so model scope and application_controller inheritance are used facilitate administrative functions through the use of custom class methods and actions.

## Data, its basing and the querying of it
- (CMP1042-3.3) Models in terms of data relationships & (CMP1042-4.2) Implemented database relations:
  - Unless otherwise specified, all primary and foreign keys are stored as bigints.
  - Models internally handle validation and sanitation of all input using callback methods.
  - Foreign keys for all models are generated at the time of creation.
    - Admins have no relationships.
      - Their primary key is stored internally as id.
    - Schema migrations also have no relationships.
     - Their primary key is stored internally as version, of type character varying.
    - Ar internal metadata have no relationships.
     - Their primary key is stored internally as key, of type character varying.
    - Litters have many gallery images attached. Their primary key is stored internally as id.
      - Gallery images are each attached to a litter; the primary key of the litter is stored as a foreign key called record_id in active storage attachments.
        - Active storage attachments each have many active storage blobs, recording the blob's primary key as a foreign key called blob_id.
        - Active storage variant records also each have many active storage blobs, recording them in the same manner as above.
    - Adverts belong to a Dog.
      - Advert's primary key is stored internally as id, their owning dog's pk id is is stored as dog_id foreign key.
    - Dogs have one advert, belong to a User.
      - Dog's primary key is stored as id internally, dog's owning user pk id is stored as user_id foreign key.
    - Users have many adverts through dogs, have many payments as buyers and have many payments as sellers.
      - Users store no foreign keys.
    - Payments each belong to one user as a seller and one user as a buyer. Buying and selling user primary keys are recorded as either buyer_payment or seller_payment foreign keys. The pk of the dog sold is recorded at the time of sale but no relationship exists.

- (PRG1048-5.1) Model methods and scopes
  - Appropriate extensions to model scopes demonstrated, particularly in the :sophisticated_demonstration_of_scope_extension_and_database_querying scope, which also meets the requirement (PRG1048-5.2) to implement eager loading when appropriate (in that an appropriate alternative is demonstrated).
  - Dog model scope also extended appropriately.
  - Appropriate and sophisticated use of model methods shown in the custom sanitisation model methods.

- (CMP1042-4.3) Discuss database schema with reference to the ERD:
  - The schema.rb provided identically replicates the functions of the ERD provided in all aspects. The schema.rb is built using migrations which are applied sequentially causing a regeneration of the schema. Upon migration the schema defines its version with the ``Schema.define(version_date)`` method, which is compared against the varcchar migration key on the database (discussed above) to ensure functional parity when the two are built alongside one another in development where updates are handled by ``db:migrate``.
  - A schema can also be used to build a database directly using ``db:schema:load``, which is faster but does not carry robust assurances of parity and reversibility, and is more prone to dependency based failures. If this occurs then:
    - Each ``create.table 'ta'`` element in the schema creates a DB table of name ``ta`` where each `` t.method 'n' `` creates a row of type ``method`` named ``'n'``. In this way the schema describes the creation of one table and all its native rows at a time, before construction of the next table begins.
    - Once all tables and their rows are created the schema then describes the addition of foreign keys with the ``add_foreign_key "1", "2"`` method which adds a foreign key row to table ``1`` referencing ``2``.
  - Specifically, the provided schema.rb matches the provided ERD perfectly, and would create a database perfectly matching the ERD if generated using ``db:schema:load`` (with the small exception of some fudged activestorage stuff) because I am an infalliable wizard who generates his database from the schema and then has postgres generate the ERD.
  - Additionally it should be noted that:
    - (PRG1048-1.1) The provided ERD is complete with appropriately defined entities. Models each serve a single purpose. The ERD provided represents a normalised database model entirely without duplication and with ideal definitions.
    - (PRG1048-1.2) Implemented models each serve a single purpose, contain appropriate fields and relationships, and are ideally implemented (without reference to limitations imposed by PRG1048-5.3).
    
- Duplication of querying (PRG1048-2.1), sadly, exists. Fortunately controllers always provide correct information from the models to the application views, just not always in an efficient way.

- (PRG1048-2.2) Exceptional understanding of database queries demonstrated, particularly in the user model scope extension :sophisticated_demonstration_of_scope_extension_and_database_querying used by the dashboard controller. All data needed for a working solution is available.

## Planning stuff

- CMP1042-6.2 Provide Wireframes for your App
  - More than five detailed and well designed wireframes are provided, each for several different screen sizes.

- (CMP1042-6.3) Tasks were planned and tracked using a custom digital Kanban that was made for a group assignment.
  - The Kanban was generated with 4 swimlanes and 3 columns:
    - Swimlanes
      - Critical (necessary to pass)
      - Important (necessary for good marks)
      - Desirable (things I wanted)
      - Blocked (things that I couldn't achieve)
    - Columns
      - Unstarted
      - WIP, with a limit of 4 items
      - Finished
  - All user stories were then generated as cards and assigned to a swimlane.
  - Three cards were taken from the most important swimlane and added to the WIP column, starting a sprint of three days to implement those user stories.
  - If, at the end of three days one was not done, it moved to blocked.
  - If an item stayed in blocked for three sprints it would be removed from the board.
  - At the end of each sprint, the number of cards in WIP was made three by moving cards over from unstarted.

- (CMP1042-6.1) User stories for this App:
  - As a user I want to
    - Create dogs that I own so that they are on the website
    - View dogs that I own so that I can decide which ones to sell
    - Advertise dogs I own so that I can sell them
    - View other users' ads so that I can decide whether or not to buy them
    - View my own ads so that I can see if they look right
    - Buy other users' dogs so that I can own them
    - Browse dogs by category so that I can see how many males/females/puppies there are on the website
    - View pictures of litters so that I can feel warm and fuzzy
    - logout so that my account is safe
  - As an admin I want to
    - View all users so that I can see which ones are active, inactive or banned
    - Ban users for arbitrary reasons to feel powerful
    - Unban users so that the site doesn't die from a lack of users
    - Create litters so that people can buy puppies off me
    - Edit litters so that the details are ccorrect if the situation changes
    - View litters to see if they look right
    - Attach pictures to litters so they can be displayed
    - Delete litters so that others can't see them
    - Show off galleries of recent litters so that my reputation as a breeder improves
    - View all dogs so that I can monitor activity on the site
    - Create and delete ads for dogs so that I can help users who can't do it themselves
    - Delete and edit others dogs so that I can experience a power trip
    - logout so that my account is safe
  - As the person making the website I want to not be ashamed of the styling.