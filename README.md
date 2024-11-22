# Homelessness Navigator: Creating a Knowledge Graph and User-Centric UI/UX Design for Social Services and Living Resources 

## Project Overview 
The Homelessness Navigator project aims to create a comprehensive knowledge graph that connects homeless individuals with essential services such as shelters and food banks. By leveraging advanced data structuring techniques, the project seeks to facilitate easy access to information, enabling users to find the resources they need quickly and efficiently.  This project was sponsored by [KnowHax](https://app.knowhax.com/challenge_pop-hack/1727888126435x823821229288511500) and the research started by [Temple University](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2333703&HistoricalAwards=false) under Dr. Yuzhou Chen.  

## Potential Stakeholders
The success of the Homelessness Navigator project depends on the collaboration of various stakeholders, including People Experiencing Homelessness (PEH), who will provide insights to shape the platform; case workers, who can enhance their support using the knowledge graph; and non-profit organizations that will contribute data and promote the platform. Federal agencies like the U.S. Interagency Council on Homelessness can lend legitimacy and resources, while local governments facilitate access to local data and integration into services. Additionally, community members can raise awareness and offer local insights. Together, these stakeholders will help create a comprehensive resource empowering individuals experiencing homelessness to access essential services.

## Key Project Features 
- Knowledge Graph Development: The project will construct a dynamic knowledge graph that integrates various data sources related to homelessness services. This graph will include information on locations, availability, eligibility criteria, and user reviews of shelters and food banks.
  
- User-Centric UX/UI Design: A significant focus will be placed on designing an intuitive user interface that caters specifically to the needs of homeless individuals. The design will prioritize simplicity and accessibility, ensuring that users can navigate the platform with ease, regardless of their technological proficiency.
  
- Search Functionality: The platform will feature a robust search engine that allows users to query the knowledge graph effectively. Users will be able to search for services based on their immediate needs, such as "shelters near me" or "food banks open today."

## Data
Sample shelter and food bank datasets were provided by Dr. Chen that spanned across Pennsylvania, California, and British Columbia.  Key features include, but are not limited to, the following:

- Shelter/Food Bank's name, location, website
- Unstructured Notes/Description columns that could include additional information such as operating hours, income restrictions, specific resources (warm meals), etc.

One of the considerations of this project is to pull out important information from the unstructured text column that can enhance Knowledge Graph and UI searchability and overall user experience. 

## Ontology
[Web Protege](https://webprotege.stanford.edu/) desktop was used to map out the classes, object properties, data properties, and instances.  This image was created and used to develop the ontology:

![Ontology Diagram](ontology.png)

### Knowledge Graph (LLM) 
Two knowledge graphs were created for the project.  The first knowledge graph focused on preparing a text document from the static files, reading in the custom ontology turtle file, and using an OpenAI API environment to generate a Cypher Script.  Here is some snapshots of the code (Full Code Can be Found Here):

1. Creating a document.txt file from the 3 CSV files given
![Documents](images/documentcode.png)

2. Chunking up the document.txt file and creating a Graph object to read in custom ontology
![Chunking](images/chunkingcode.png)

3. Giving the LLM a specific system message and prompt to produce Cypher code that then can be read into Neo4j
![Prompt](images/systemprompt.png)

4. Post-processing the text to make a Knowledge Graph on Neo4j Aura.  In this image it is showing the age eligibility requirement for a Senior Food Program. 
![KG1](images/LLMgraph.png)



### UX/UI Design 

## Recommendations & Insights 

## Future Steps 

## Contributors 
Angelica Spratley (Jelly): [LinkedIn](https://linkedin.com/in/angelicaspratley)<br />

Garrett Smith: [LinkedIn](https://linkedin.com/in/garrett55smith)
Grazia Maszak-Prato: [LinkedIn](https://linkedin.com/in/graziaprato)
Robert Yates: 
Vijaya Sekar: [LinkedIn](https://linkedin.com/in/vijaya-sekar)
