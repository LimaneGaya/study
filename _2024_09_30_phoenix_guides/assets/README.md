## Managing Your Web App's Assets Like a Pro

When building web applications, we don't just deal with HTML. We also have a bunch of other files like JavaScript, CSS, images, and fonts – these are called **assets**.  Phoenix makes managing these assets easy, even if you're new to web development.

### Understanding the Basics

Phoenix uses powerful tools to handle your assets:

- **esbuild:** This tool takes your JavaScript code (usually found in `assets/js/app.js`) and transforms it into a more efficient format that browsers understand. It then places the processed file in `priv/static/assets/app.js`. This happens automatically in development and when you run `mix assets.deploy` for production.

- **tailwindcss:**  This is your go-to for styling your application with CSS. It takes care of building your CSS and making it look great.

- **priv/static:** This folder is where you put all other assets that don't require any special processing, like images or fonts.

### Working with JavaScript Libraries

Often, you'll want to use existing JavaScript libraries (like a cool date picker or a charting tool) in your project.  Here's how you can do that:

**1. Vendor (Copy) the Library:**

   - Download the library's files and place them in a folder inside your `assets` directory (e.g., `assets/vendor`).
   - Import the library into your `assets/js/app.js` using a relative path:

     ```javascript
     import topbar from "../vendor/topbar" 
     ```

**2. Use npm:**

   - If you're familiar with npm (Node Package Manager), you can use it to install the library directly into your `assets` directory:

     ```bash
     cd assets 
     npm install topbar --save
     ```

   - Then, import it in your `app.js` just like you would any other JavaScript module:

     ```javascript
     import topbar from "topbar"
     ```

**3. Use Mix (Recommended for Phoenix Projects):**

   - This is the Phoenix way! You add the library as a dependency in your `mix.exs` file:

     ```elixir
     # mix.exs
     {:topbar, github: "buunguyen/topbar", app: false, compile: false} 
     ```

   - Fetch the library by running `mix deps.get`.
   - Import it in your `app.js`:

     ```javascript
     import topbar from "topbar" 
     ```

   This approach is great because it keeps track of the library's version and makes updates easy.

### Handling Images, Fonts, and Other External Files

When you link to images or fonts in your CSS or JavaScript, `esbuild` wants to make sure those files exist. Sometimes, it might complain with an error like this:

```
error: Could not resolve "/images/bg.png" (mark it as external to exclude it from the bundle)
```

This happens because `esbuild` thinks you want it to bundle those files with your JavaScript. But for files in `priv/static`, Phoenix already handles them! So, we need to tell `esbuild` to leave them alone.

Phoenix does this automatically for you by marking `/images` and `/fonts` as "external" in your `config/config.exs`:

```elixir
args: ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
```

If you have other folders you need `esbuild` to ignore, just add them to the `--external` list. 

**Cache Busting:** Don't worry, your images and fonts will still be cache-busted (meaning browsers will download the latest versions) because `mix phx.digest` takes care of that.

### Advanced: Customizing esbuild with Plugins

`esbuild` is super flexible. You can add **plugins** to do even more, like compiling SASS files to CSS. This requires a bit more setup:

1. **Install Node.js:** You'll need Node.js for this.
2. **Install esbuild and Phoenix Dependencies (using npm or yarn):**

   ```bash
   cd assets
   npm install esbuild --save-dev
   npm install ../deps/phoenix ../deps/phoenix_html ../deps/phoenix_live_view --save 
   ```

3. **Create a Custom Build Script:** Create a JavaScript file (e.g., `assets/build.js`) to configure `esbuild` and your plugins. You can find an example of such a script in the original documentation I provided.
4. **Update Your Phoenix Configuration:** 
   - Modify `config/dev.exs` to use your new build script when watching for changes.
   - Update the `aliases` in `mix.exs` to install npm packages during setup and use the new `esbuild` script for deployment. 
5. **Remove the Default esbuild Configuration:** You no longer need the default `esbuild` settings in `config/config.exs` and the `esbuild` dependency in `mix.exs`.

### Using Different Build Tools or CSS Frameworks

If you want complete control or prefer a different tool altogether, you can remove the default `esbuild` and `tailwind` setup:

**Removing esbuild:**

1. Remove `esbuild` configurations from `config/config.exs` and `config/dev.exs`.
2. Remove the `assets.deploy` task from `mix.exs`.
3. Remove the `esbuild` dependency from `mix.exs`.
4. Unlock the dependency: `mix deps.unlock esbuild`

**Removing tailwind:**

1. Remove `tailwind` configurations from `config/config.exs` and `config/dev.exs`.
2. Remove the `assets.deploy` task from `mix.exs`.
3. Remove the `tailwind` dependency from `mix.exs`.
4. Unlock the dependency: `mix deps.unlock tailwind`
5. Optionally remove the `heroicons` dependency if you're not using it.

After removing the default tools, you can integrate your preferred build system or CSS framework by following their respective documentation.
