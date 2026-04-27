namespace oop5
{
    public class CaesarStream : Stream
    {
        private Stream _stream;
        private static int _shift = 0;

        public CaesarStream(Stream stream, int shift)
        {
            this._stream = stream;
            _shift += shift;
        }

        public override bool CanRead => _stream.CanRead;

        public override bool CanSeek => _stream.CanSeek;

        public override bool CanWrite => _stream.CanWrite;

        public override long Length => _stream.Length;

        public override long Position 
        { 
            get => _stream.Position; 
            set => _stream.Position = value; 
        }

        public override void Flush()
        {
            _stream.Flush();
        }

        public override int Read(byte[] buffer, int offset, int count)
        {
            int result = _stream.Read(buffer, offset, count);
            for (int i = 0; i < buffer.Length; i++)
            {
                buffer[i] = (byte)((buffer[i] + _shift) % 255);
            }
            return result;
        }

        public override long Seek(long offset, SeekOrigin origin)
        {
            return _stream.Seek(offset, origin);
        }

        public override void SetLength(long value)
        {
            _stream.SetLength(value);
        }

        public override void Write(byte[] buffer, int offset, int count)
        {
            for (int i = 0; i < buffer.Length; i++)
            {
                buffer[i] = (byte)((buffer[i] + _shift) % 255);
            }
            _stream.Write(buffer, offset, count);
        }
    }
}
