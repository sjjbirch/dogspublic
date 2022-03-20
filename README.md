# README

Is this the right one?

- A link (URL) to your deployed app (i.e. website)
  - https://dog-fx2.herokuapp.com/doglist

- A link to your GitHub repository (repo).
  - https://github.com/sjjbirch/dogspublic

## Descriptions
- Description of app:
  - (CMP1042-3.1) This website solves the problem of Australian dog breeders, who are the target audience, not being able to easily create their own pages to display dogs and to sell dogs between each other. This is discussed in much more detail in the attached Powerpoint presentation.
  - This website features basic bootstrap styling, two devise authentication models for different roles, sanitisation and validation of all user inputs, the ability to create, view, edit and buy dogs, to advertise dogs, to view and edit adverts for dogs, to browse dogs by type using sophisticated custom scopes, to delete resources, to create upcoming litters, to attach pictures of existing litters and to show them off. It also has an integrated admin dashboard with god features. Custom callbacks have been implemented for some extensions to sanitisation.
  - A sitemap is attached in XML format.
  - (CMP1042-1.3) This site was built using Rails 6.3 and Bootstrap 3.4.1. External third party services used are a PG database on Heroku, Cloudinary active storage and Heroku hosting. Authentication has handled by Devise.

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

## Data, its basing and the querying of it
- (CMP1042-3.3) Models in terms of data relationships & (CMP1042-4.2) Implemented database relations.
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

- (CMP1042-4.3) Discuss database schema with reference to the ERD:
  - The schema.rb provided identically replicates the functions of the ERD provided in all aspects.
  - Additionally:
    - (PRG1048-1.1) The provided ERD is complete with appropriately defined entities. Models each serve a single purpose. The ERD provided represents a normalised database model entirely without duplication and with ideal definitions.
    - (PRG1048-1.2) Implemented models each serve a single purpose, contain appropriate fields and relationships, and are ideally implemented (without reference to limitations imposed by PRG1048-5.3).
    
- (PRG1048-2.1) Duplication of querying, sadly, exists. Controllers always provide correct information from the models to the application views, but not in an efficient way.

- (PRG1048-2.2) Exceptional understanding of database queries demonstrated, particularly in the dashboard user method. All data needed for a working solution is available.

- CMP1042-6.2 Provide Wireframes for your App
  - More than five detailed and well designed wireframes provided, for several different screen sizes (as required for the app)

- CMP1042-1.2 Explain the different high-level components (abstractions) in your App

- CMP1042-6.3 Describe the way tasks are planned and tracked in your project (do it by user story)

- CMP1042-3.3 Add to the above how it works.