abstract class PostRepo {
  Future fetchPosts(int fetchLimit, int offset);
  Future fetchPost(String id);
  Future createPost(Map args);
  Future deletePost(String id);
}
