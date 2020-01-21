# Phoenix Live Editable Webpack Config

Phoenix Live Editable (PLE) supports multiple CSS frameworks like Bootstrap,
Milligram, and Bulma.  PLE generates one set of JS/CSS assets per framework,
using the 'multiple entry points' capability of Webpack.

## Installing PLE in your Phoenix App

The downstream Phoenix app must:

- add PLE to the `mix.exs` dependencies
- declare your CSS framework in your application config
- pull the proper JS/CSS asset into your asset pipeline

## Multi-Framework Applications

For demos, we'll want to use multiple CSS frameworks in one application.

To do this:
- Put `Application.set_env` to set the CSS framework for each view
- Create a 'multi entry point' webpack config to generate separate assets for
  each framework.
- Use a separate layout for each framework which loads the CSS/JS assets.

See the `ledemo` for an example multi-framework application.

## Learning Webpack

I used the "[Learn Webpack Course][lw]" by [Colt Steele][cs].

[lw]: https://www.youtube.com/playlist?list=PLblA84xge2_zwxh3XJqy6UVxS60YdusY8
[cs]: https://www.youtube.com/channel/UCrqAGUPPMOdo0jfQ6grikZw
