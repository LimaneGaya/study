# Phoenix Contexts: A Guide

Contexts are dedicated modules in a Phoenix application that expose and group related functionality. They serve as boundaries to decouple and isolate parts of your application, enhancing maintainability and code reusability.  While technically just modules, they represent a key architectural pattern in Phoenix.

## Purpose of Contexts

* **Organize Business Logic:** Contexts group related functions and encapsulate business logic, keeping it separate from the web layer.
* **Data Access and Validation:** They commonly handle interactions with databases or external APIs, including data validation.
* **Decoupling:**  Contexts decouple different parts of the application, allowing changes in one area (e.g., database) without affecting others (e.g., controllers).
* **Clear API:** They provide a clear public API for accessing specific functionalities, hiding implementation details from callers.


## Working with Contexts

### Generating Contexts

Phoenix provides generators to create contexts and related files:

* **`mix phx.gen.html ContextName SchemaName plural_table_name field:type ...`**: Generates a context module, an Ecto schema, a controller, views, and templates for HTML interfaces.
* **`mix phx.gen.json ContextName SchemaName plural_table_name field:type ...`**: Similar to `phx.gen.html`, but generates JSON interfaces instead of HTML.
* **`mix phx.gen.live ContextName SchemaName plural_table_name field:type ...`**:  Generates a context, LiveView modules, and templates for interactive interfaces.
* **`mix phx.gen.context ContextName SchemaName plural_table_name field:type ...`**:  Generates a context module and an Ecto schema without web components.  Useful for adding resources to existing contexts.
* **`mix ecto.gen.migration MigrationName`**: Creates a database migration file. Often used within a context to define relationships or add fields.

### Structuring Code Inside Contexts

Contexts are the public API for a specific part of your application.  Internal organization of modules within a context (e.g., changesets, queries) is less critical.  Focus on well-defined context functions that express the intent of the code, hiding implementation details.

### Cross-Context Dependencies

When one context needs data from another, there are two main approaches:

1. **Expose APIs:**  The dependent context can call public functions on the other context to fetch required data.
2. **Database Joins:** Use database joins to retrieve related data directly, especially when there's a strong data dependency.

### Key Considerations

* **Naming:** Choose context names that clearly describe the grouped functionality.  When unsure, use the plural form of the primary resource.
* **Granularity:**  Avoid overly large contexts with loosely related entities. Start with smaller, more focused contexts and refactor as needed.
* **Data Integrity:** Leverage database constraints (e.g., foreign keys, unique indexes) to enforce data integrity whenever possible.
* **Ecto Changesets:**  Changesets are a suitable way to model data changes and validations between contexts and the web layer, regardless of the data source.


## Example: Creating a Blog Context

```bash
mix phx.gen.html Blog Post posts title:string content:text
```

This generates a `Blog` context, `Post` schema, controller, views, and templates.  You can then add custom functions to the `Blog` context (e.g., `publish_post/1`, `list_published_posts/0`) to implement specific blog features.


## FAQ

### When to use code generators?

Generators are helpful for scaffolding initial project structure and quickly creating basic CRUD operations.  They are valuable learning tools and provide a solid starting point, but custom code is often needed for real-world features.

### How to handle changesets and errors?

Changesets, even though part of Ecto, are useful data structures for validation and error handling regardless of the data source. Returning changesets from context APIs provides a consistent way to communicate validation errors to the web layer.