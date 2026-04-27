export interface Project {
    name: string;
    technologies: string;
    description: string;
    codeLink: string;
  }

export const projects: Project[] = [
    {
        name: 'Sudoku',
        technologies: 'C',
        description: 'Aplikacja okienkowa do gry w sudoku',
        codeLink: 'https://github.com/MateuszM02/projekt_sudoku',
    },
    {
        name: 'Hexapawn',
        technologies: 'Java',
        description: 'Aplikacja okienkowa do gry w hexapawn',
        codeLink: 'https://github.com/MateuszM02/hexapawn',
    },
    {
        name: 'Nonogram solver',
        technologies: 'python',
        description: 'AI rozwiązujące nonogramy metodą dedukcji',
        codeLink: 'https://github.com/MateuszM02/University/tree/main/AI/p3',
    },
    {
        name: 'Samotnik',
        technologies: 'Java',
        description: 'Aplikacja okienkowa do gry w samotnika',
        codeLink: 'https://github.com/MateuszM02/University/tree/main/Java/zad7samotnik',
    },
    {
        name: 'Platforma z grami',
        technologies: 'Javascript, Html, CSS',
        description: 'Aplikacja webowa do gry dwuosobowej w Kółko i krzyżyk, reversi i connect4',
        codeLink: 'https://github.com/MateuszM02/University/tree/main/WEPPO/lista8_ProjektPlatformaGier',
    },
    {
        name: 'Projekt z figurami',
        technologies: 'Java',
        description: 'Aplikacja konsolowa do różnych operacji na figurach geometrycznych',
        codeLink: 'https://github.com/Acors24/one-of-the-repos-ever',
    },
];