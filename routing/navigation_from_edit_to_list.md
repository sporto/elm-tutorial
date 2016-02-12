# Navigation from Edit to List

Finally, let's add a back to list button to the edit view.





There is one important line in the `nav` function above:

```elm
a [ class "btn button-narrow", href "#/players" ] [ i [ class "fa fa-chevron-left" ] [], text " Players" ]
```

Here we have a link that will trigger a browser location change thus showing the players' list again.








