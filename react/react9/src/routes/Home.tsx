import muskImage from './musk.jpg';
import { Box, Typography, IconButton } from '@mui/material';
import TwitterIcon from '@mui/icons-material/Twitter';
import FacebookIcon from '@mui/icons-material/Facebook';
import useStyles from '../styling/styles';

export default function Home() {
  const css = useStyles();

  return (
    <Box style={{ textAlign: 'center' }}>
      <img src={muskImage} alt="Elon Musk" className={css.Image} />
      <Typography variant="h6" component="h2">
        Elon Musk
      </Typography>
      <Typography>
        Przedsiębiorca i innowator znany z założenia SpaceX i współzałożenia Tesli.
      </Typography>
      <Box>
        <IconButton aria-label="Twitter" onClick={() => window.open('https://twitter.com/elonmusk', '_blank')}>
          <TwitterIcon />
        </IconButton>
        <IconButton aria-label="LinkedIn" onClick={() => window.open('https://www.facebook.com/profile.php?id=61555929278044', '_blank')}>
          <FacebookIcon />
        </IconButton>
      </Box>
    </Box>
  );
}