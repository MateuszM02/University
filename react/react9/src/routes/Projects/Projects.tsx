import { useState } from 'react';
import { Box, Typography, Link, Grid, Paper } from '@mui/material';
import { Project, projects } from './data';
import useStyles from "../../styling/styles";

function ProjectTile({ project, isSelected, onSelect } : { project: Project; isSelected: boolean; onSelect: () => void }) {
  const css = useStyles();
  
  return (
    <Paper className={css.Tile} onClick={onSelect}>
      <Typography variant="h6">{project.name}</Typography>
      {isSelected && (
        <>
          <Typography>{project.technologies}</Typography>
          <Typography>{project.description}</Typography>
          <Link href={project.codeLink} target="_blank" rel="noopener">
            Kod źródłowy
          </Link>
        </>
      )}
    </Paper>
  );
}

export default function Projects() {
  const [selectedProject, setSelectedProject] = useState<string | null>(null);

  const handleSelectProject = (projectName: string) => {
    if (selectedProject === projectName) {
      setSelectedProject(null); // Deselect if the same project is clicked again
    } else {
      setSelectedProject(projectName); // Select the new project
    }
  };

  return (
    <Box>
      <Typography variant="h4" gutterBottom>
        Moje Projekty
      </Typography>
      <Grid container spacing={2}>
        {projects.map((project, index) => (
          // <Grid item xs={12} key={project.name}>
          <Grid item xs={2} key={index}>
            <ProjectTile
              project={project}
              isSelected={selectedProject === project.name}
              onSelect={() => handleSelectProject(project.name)}
            />
          </Grid>
        ))}
      </Grid>
    </Box>
  );
}