import { Container } from '@mui/material'
import Header from './components/Header'
import { MyTable } from './components/MyTable';

function App() {
  return (
    <Container>
      <Header />
      <MyTable />
    </Container>
  )
}

export default App;