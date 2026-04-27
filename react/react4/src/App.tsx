import './App.css'
import View from './Graphics';
import RecipeProvider from './RecipeContext'

function App() {

  return (
    <RecipeProvider>
      <View />
    </RecipeProvider>
  )
}

export default App;