using System.IO;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace zad2
{
    public enum Player { X, O, None }
    public enum Winner { X, O, Draw, Playing }

    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private int moves_;
        private Player player_;
        private Player[][] board_;
    
        public MainWindow()
        {
            InitializeComponent();
            ResetGame();
        }
        
        private void ResetGame()
        {
            // initialize board
            whoseMoveTxtblock.Text = $"Tura gracza: X";
            moves_ = 0;
            player_ = Player.X;
            board_ = new Player[3][];

            for (int row = 0; row < 3; row++)
            {
                board_[row] = new Player[3];
                for (int col = 0; col < 3; col++)
                {
                    Button btn = (Button)this.FindName($"b{row}{col}");
                    btn.Content = "";
                    board_[row][col] = Player.None;
                }
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Button clickedButton = (Button)sender;
            string btnName = clickedButton.Name;
            int row = int.Parse(btnName[1].ToString());
            int col = int.Parse(btnName[2].ToString());

            // ignore clicks on already selected positions
            if (board_[row][col] != Player.None)
                return;

            moves_++;
            board_[row][col] = player_;
          
            // add player piece to GUI
            byte[] byteArray = player_ == Player.X ? MyImages.X : MyImages.O;
            clickedButton.Content = new Image
            {
                Source = ByteArrayToImage(byteArray),
                Stretch = Stretch.Fill,
            };

            ChangePlayer();
            whoseMoveTxtblock.Text = $"Tura gracza: {player_}";
            
            // check for winner
            Winner winner = GetWinner();
            string msg;
            switch (winner)
            {
                case Winner.Draw:
                    msg = "Draw";
                    break;
                case Winner.X:
                    msg = "X won";
                    break;
                case Winner.O:
                    msg = "O won";
                    break;
                case Winner.Playing:
                    return;
                default: 
                    throw new ArgumentException("Bad type of Winner");
            }
            MessageBox.Show(msg, "Game ended");
            ResetGame();
        }

        #region Check who wins
        private Winner GetWinner()
        {
            for (int i = 0; i < 3; i++)
            {
                // check 3 in a row
                if (CheckRow(i) && board_[i][0] != Player.None)
                    return PlayerToWinner(board_[i][0]);
                // check 3 in a column
                else if (CheckColumn(i) && board_[0][i] != Player.None)
                    return PlayerToWinner(board_[0][i]);
            }
            //check 3 in diagonal
            if (CheckDiagonals())
                return PlayerToWinner(board_[1][1]);

            // no winner
            if (moves_ < 9)
                return Winner.Playing;
            return Winner.Draw;
        }

        private bool CheckRow(int row)
        {
            return board_[row][0] == board_[row][1] &&
                    board_[row][1] == board_[row][2];
        }

        private bool CheckColumn(int col)
        {
            return board_[0][col] == board_[1][col] &&
                    board_[1][col] == board_[2][col];
        }

        private bool CheckDiagonals()
        {
            bool topLeftBottomRight =
                board_[0][0] == board_[1][1] &&
                board_[1][1] == board_[2][2];
            return topLeftBottomRight ||
                board_[0][2] == board_[1][1] &&
                board_[1][1] == board_[2][0];
        }
        #endregion

        #region Helpers
        public static BitmapImage ByteArrayToImage(byte[] byteArray)
        {
            using (MemoryStream ms = new(byteArray))
            {
                BitmapImage bitmapImage = new();
                bitmapImage.BeginInit();
                bitmapImage.StreamSource = ms;
                bitmapImage.CacheOption = BitmapCacheOption.OnLoad;
                bitmapImage.EndInit();
                return bitmapImage;
            }
        }

        private void ChangePlayer()
        {
            switch(player_)
            {
                case Player.X: 
                    player_ = Player.O;
                    return;
                case Player.O:
                    player_ = Player.X;
                    return;
                default:
                    throw new ArgumentException("Bad type of player");
            }
        }

        private static Winner PlayerToWinner(Player player)
        {
            return player switch
            {
                Player.X => Winner.X,
                Player.O => Winner.O,
                Player.None => Winner.Playing,
                _ => throw new ArgumentException("Bad type of player"),
            };
        }
        #endregion
    }
}