import useStyles from "../../styling/styles";
import muskImage from "../musk.jpg";
import { Category, Item, info } from "./data";

import { Box, Typography, List, ListItem, ListItemText, Paper } from '@mui/material';

function ItemList({ items }: { items: Item[] }) {
  return (
    <List >
      {items.map((item: Item) => (
          <ListItem >
            <ListItemText primary={item.primary} secondary={item.secondary} />
          </ListItem>
      ))}
    </List>
  );
}

export default function AboutMe() {
  const css = useStyles();

  return (
    <Box sx={{ textAlign: 'center', my: 4 }}>
      {/* <Avatar
        src={muskImage}
        alt="Elon Musk"
        className={css.Image}
      /> */}
      <img src={muskImage} alt="Elon Musk" className={css.Image} />
      <Typography variant="h4" component="h1" gutterBottom>
        Elon Musk
      </Typography>
      <Typography variant="subtitle1" gutterBottom>
        Przedsiębiorca i innowator znany z założenia SpaceX i współzałożenia Tesli.
      </Typography>
      <Box sx={{ textAlign: 'left', mx: 'auto', maxWidth: 600 }}>
        {info.map((category: Category) => (
          <>
            <Typography variant="h6">
              {category.title}
            </Typography>
            <Paper className={css.Category}>
              <ItemList items={category.items} />
            </Paper>
          </>
        ))}
      </Box>
    </Box>
  );
};