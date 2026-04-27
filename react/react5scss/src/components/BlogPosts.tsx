import classes from "../styles/BlogPosts.module.scss";

type BlogPost = {
    id: number,
    title: string,
    date: string,
    content: string
}

const BlogPosts = ({ blogPosts }: { blogPosts: BlogPost[] }) => {
    return (
        <div className={classes.blogPosts}>
            {blogPosts.map((post) => (
                <div key={post.id} className={classes.blogPost}>
                    <h3>{post.title}</h3>
                    <p>{post.date}</p>
                    <p>{post.content}</p>
                    <button type="button" className={classes.readMoreButton}>Read More</button>
                </div>
            ))}
        </div>

    );
};

export default BlogPosts;